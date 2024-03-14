import Combine
import UIKit

// A generic UIViewController subclass for MVVM architecture
public class GenericMVVMController<ViewModel>: UIViewController where ViewModel: BaseViewModel {
    
    // Public Properties
    public let viewModel: ViewModel
    public var isViewVisible: Bool = false
    public var cancellables = Set<AnyCancellable>()
    
    // Private Properties
    private var stateSubscription: AnyCancellable?

    // Lifecycle
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
        bindViewModel()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isViewVisible = true
        viewModel.onViewWillAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isViewVisible = false
        viewModel.onViewWillDisappear()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isViewVisible = true
        viewModel.onViewDidAppear()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isViewVisible = false
        viewModel.onViewDidDisappear()
    }

    // Binding the view model state to the view controller
    private func bindViewModel() {
        stateSubscription = viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updateView(with: state)
            }
        stateSubscription?.store(in: &cancellables)
    }

    // Method to update the view with new state
    public func updateView(with state: ViewModel.ViewState) {
        // Override to update UI or crash
        fatalError()
    }
}
