public protocol ViewState {
    init()
}

public extension ViewState {
    mutating func update(_ block: (inout Self) -> Void) {
        var copy = self
        block(&copy)
        self = copy
    }
}

