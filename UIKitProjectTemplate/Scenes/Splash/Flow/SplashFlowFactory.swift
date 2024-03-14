import Foundation

public protocol SplashFlowFactory {
    func makeFlow() -> any SplashFlow
}

public class SplashFlowFactoryImpl {
    public init() { }
}

extension SplashFlowFactoryImpl: SplashFlowFactory {
    public func makeFlow() -> any SplashFlow {
        return SplashFlowImpl(splashFactory: SplashFactoryImpl())
    }
}
