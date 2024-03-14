import Foundation

enum CachePolicy {
    case cacheFirst
    case networkFirst
    // Add more caching strategies as needed
}

class CacheManager {
    static let shared = CacheManager()

    private let cache = NSCache<NSURL, AnyObject>()

    private init() {}

    func save<T: Codable>(data: T, for url: URL) {
        cache.setObject(data as AnyObject, forKey: url as NSURL)
    }

    func get<T: Codable>(url: URL) -> T? {
        return cache.object(forKey: url as NSURL) as? T
    }
}
