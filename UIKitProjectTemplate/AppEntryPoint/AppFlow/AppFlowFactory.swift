public protocol AppFlowFactory {
    func makeFlow() -> any AppFlow
}

public class AppFlowFactoryImpl {
    public init() { }
}

extension AppFlowFactoryImpl: AppFlowFactory {
    public func makeFlow() -> any AppFlow {
        return AppFlowImpl(
            splashFlowFactory: SplashFlowFactoryImpl()
        )
    }
}
