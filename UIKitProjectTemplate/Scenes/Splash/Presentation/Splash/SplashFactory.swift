import UIKit

protocol SplashFactory {
    func makeViewController(input: SplashInput, handlers: SplashHandlers) -> UIViewController
}

class SplashFactoryImpl { }

extension SplashFactoryImpl: SplashFactory {
    func makeViewController(input: SplashInput, handlers: SplashHandlers) -> UIViewController {
        let viewModel = SplashViewModelImpl(input: input, handlers: handlers)
        let view = SplashViewController(viewModel: viewModel)
        return view
    }
}
