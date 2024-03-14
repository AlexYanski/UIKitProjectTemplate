import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
    // Add more error cases as needed
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkServiceProtocol {
    func request<T: Codable>(url: URL, method: HTTPMethod, parameters: [String: Any]?, cachePolicy: CachePolicy, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func request<T: Codable>(url: URL, method: HTTPMethod = .get, parameters: [String: Any]? = nil, cachePolicy: CachePolicy = .networkFirst, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let parameters = parameters {
            switch method {
            case .get:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                if let urlWithQuery = components?.url {
                    request.url = urlWithQuery
                }
            case .post, .put, .delete:
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }

        // Check cache first if applicable
        if cachePolicy == .cacheFirst, let cachedData: T = CacheManager.shared.get(url: url) {
            completion(.success(cachedData))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)

                // Cache response if needed
                if cachePolicy == .cacheFirst {
                    CacheManager.shared.save(data: decodedObject, for: url)
                }

                completion(.success(decodedObject))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
}
