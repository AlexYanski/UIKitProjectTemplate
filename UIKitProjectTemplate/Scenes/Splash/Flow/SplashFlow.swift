import UIKit

public typealias SplashFlowInput = Void

public struct SplashFlowHandlers {
    public init() { }
}

public protocol SplashFlow: Flow where Input == SplashFlowInput, Handlers == SplashFlowHandlers {}

class SplashFlowImpl {
    private let splashFactory: SplashFactory

    init(splashFactory: SplashFactory) {
        self.splashFactory = splashFactory
    }
}

extension SplashFlowImpl: SplashFlow {
    func makeStartViewController(input: SplashFlowInput, handlers: SplashFlowHandlers) -> UIViewController {
        let handlers = SplashHandlers(
            routeToHome: {
                
            }, routeToWelcome: {
                
            }, routeToOnboarding: {
                
            })
        return splashFactory.makeViewController(input: (), handlers: handlers)
    }
}
