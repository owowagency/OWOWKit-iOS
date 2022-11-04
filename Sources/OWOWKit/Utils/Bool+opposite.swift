import Foundation

extension Bool {
    /// Equal to using the `!` operator, but useful for creating bindings etc.
    @inlinable
    public var opposite: Bool {
        get {
            return !self
        }
        set {
            self = !newValue
        }
    }
}
