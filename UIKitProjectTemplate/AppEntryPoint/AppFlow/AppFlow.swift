import UIKit

public struct AppFlowInput {
    public static let empty: AppFlowInput = .init()

    public init() { }
}

public struct AppFlowHandlers {
    public static let empty: AppFlowHandlers = .init()

    public init() { }
}

public protocol AppFlow: Flow where Input == AppFlowInput, Handlers == AppFlowHandlers { }


class AppFlowImpl {
        
    private let splashFlowFactory: SplashFlowFactory

    init(splashFlowFactory: SplashFlowFactory) {
        self.splashFlowFactory = splashFlowFactory
    }
}

extension AppFlowImpl: AppFlow {
    public func makeStartViewController(input: AppFlowInput, handlers: AppFlowHandlers) -> UIViewController {
        let flow = splashFlowFactory.makeFlow()
        return flow.makeStartViewController(input: (), handlers: .init())
    }
}


