import Foundation
import Combine

typealias SplashInput = Void

struct SplashHandlers {
    let routeToHome: () -> Void
    let routeToWelcome: () -> Void
    let routeToOnboarding: () -> Void
}

class SplashViewModelImpl: GenericViewModel<SplashViewState, SplashInput, SplashHandlers> {

    //  MARK: - Use Cases
    
    //  MARK: - Logic
        
    @Published private var viewDidAppear: Bool = false
    
    //  MARK: - Lifecycle
    
    override func onViewDidLoad() {
        super.onViewDidLoad()
    }
    
    override func onViewDidAppear() {
        super.onViewDidAppear()
        
        self.viewDidAppear = true
    }
}

//  MARK: - Logic

private extension SplashViewModelImpl {
    
    func performRouting() {
        
    }
}


//  MARK: - ViewModelImpl

extension SplashViewModelImpl: SplashViewModel { }

//  MARK: - Mapping

private extension SplashViewModelImpl { }

//  MARK: - Helpers

private extension SplashViewModelImpl { }
