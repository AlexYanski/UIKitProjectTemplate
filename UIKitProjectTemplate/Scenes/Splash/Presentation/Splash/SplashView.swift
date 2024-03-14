import UIKit
import SnapKit

// Defining the state for the Splash Screen
struct SplashViewState: ViewState {
    // Define properties relevant to the splash screen's state
}

protocol SplashViewModel: BaseViewModel where ViewState == SplashViewState { }

class SplashViewController<ViewModel: SplashViewModel>: GenericMVVMController<ViewModel> {
    
    // MARK: - UI Elements
    
    private let logoView = UILabel()
    
    //  MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    // Update view with new state
    override func updateView(with state: ViewModel.ViewState) {
        // Update UI based on state
    }
}

//  MARK: - UI

private extension SplashViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        logoView.text = "UIKit Project Template"
        logoView.font = .systemFont(ofSize: 32.0)
        logoView.textAlignment = .center
        
        view.addSubview(logoView)
        
        logoView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.top.greaterThanOrEqualToSuperview()
        }
    }
}
