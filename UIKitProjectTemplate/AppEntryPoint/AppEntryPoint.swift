import UIKit

public class AppEntryPoint {
        
    private let appFlowFactory = AppFlowFactoryImpl()
        
    public init() {}
}


public extension AppEntryPoint {
    func start(window: UIWindow) {
        let flow = appFlowFactory.makeFlow()
        
        window.rootViewController = flow.makeStartViewController(
            input: AppFlowInput(),
            handlers: AppFlowHandlers()
        )
        window.makeKeyAndVisible()
    }
}
