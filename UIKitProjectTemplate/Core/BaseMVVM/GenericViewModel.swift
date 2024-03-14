import Combine
import Foundation

// Defining a general protocol for View Models
public protocol BaseViewModel {
    associatedtype ViewState
    var statePublisher: AnyPublisher<ViewState, Never> { get }
    func onViewDidLoad()
    func onViewWillAppear()
    func onViewDidAppear()
    func onViewWillDisappear()
    func onViewDidDisappear()
}

// A generic base class for view models, adopting the GeneralViewModel protocol
public class GenericViewModel<ViewStateType, InputType, HandlersType>: BaseViewModel, ObservableObject where ViewStateType: ViewState {
    
    @Published var state = ViewStateType()
    public var statePublisher: AnyPublisher<ViewStateType, Never> {
        $state.eraseToAnyPublisher()
    }
    
    public let input: InputType
    public let handlers: HandlersType
    
    public var cancellables = Set<AnyCancellable>()

    public init(input: InputType, handlers: HandlersType) {
        self.input = input
        self.handlers = handlers
    }

    public func onViewDidLoad() { }
    public func onViewWillAppear() { }
    public func onViewDidAppear() { }
    public func onViewWillDisappear() { }
    public func onViewDidDisappear() { }

    // Method to update the state in a controlled manner
    public func updateState(update: (inout ViewStateType) -> Void) {
        var state = self.state
        update(&state)
        self.state = state
    }
}
