import UIKit

public protocol ScreenFactory: AnyObject {
    associatedtype Input
    associatedtype Handlers
    func makeViewController(input: Input, handlers: Handlers) -> UIViewController
}

open class BaseScreenFactory {
    public init() {}
}
