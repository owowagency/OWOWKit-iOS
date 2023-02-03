/// A property wrapper that increments it's wrapped value by the configured `incrementBy` value (default 1) every time it is read.
@propertyWrapper
public struct IncrementAfterRead<Number: BinaryInteger> {
    private var storage: Number
    public var incrementBy: Number
    
    public var wrappedValue: Number {
        mutating get {
            defer { storage += incrementBy }
            return storage
        }
        set {
            storage = newValue
        }
    }
    
    public init(wrappedValue: Number, incrementBy: Number = 1) {
        self.storage = wrappedValue
        self.incrementBy = incrementBy
    }
}
