import SwiftUI

/// The native type backing `OWOWScrollView`, aliased like this to make changing the type easier.
public typealias _OWOWScrollViewNativeType = UIScrollView

public protocol _ScrollViewConfigurationItemProtocol {
    func apply(to view: _OWOWScrollViewNativeType)
}

public struct _ScrollViewConfigurationItem<Value>: _ScrollViewConfigurationItemProtocol {
    let keyPath: ReferenceWritableKeyPath<_OWOWScrollViewNativeType, Value>
    let value: Value
    
    @usableFromInline
    init(keyPath: ReferenceWritableKeyPath<_OWOWScrollViewNativeType, Value>, value: Value) {
        self.keyPath = keyPath
        self.value = value
    }
    
    public func apply(to view: _OWOWScrollViewNativeType) {
        view[keyPath: keyPath] = value
    }
}

fileprivate struct ScrollViewConfigurationKey: EnvironmentKey {
    static let defaultValue: [_ScrollViewConfigurationItemProtocol] = []
}

internal extension EnvironmentValues {
    var scrollViewConfiguration: [_ScrollViewConfigurationItemProtocol] {
        get {
            return self[ScrollViewConfigurationKey.self]
        }
        set {
            self[ScrollViewConfigurationKey.self] = newValue
        }
    }
}

@usableFromInline
struct _ScrollViewConfigurationModifier: ViewModifier {
    @Environment(\.scrollViewConfiguration) var scrollViewConfig
    
    var item: _ScrollViewConfigurationItemProtocol
    
    @usableFromInline
    init(item: _ScrollViewConfigurationItemProtocol) {
        self.item = item
    }
    
    @usableFromInline
    func body(content: Content) -> some View {
        var config = scrollViewConfig
        config.append(item)
        return content.environment(\.scrollViewConfiguration, config)
    }
}

public extension View {
    /// Set a configuration value for `key` on instances of `UIScrollView` that are wrapped by `OWOWScrollView`.
    ///
    /// - Parameters:
    ///    - keyPath: The key path of the property to set.
    ///    - value: The value to set.
    @inlinable func scrollView<T>(_ keyPath: ReferenceWritableKeyPath<_OWOWScrollViewNativeType, T>, _ value: T) -> some View {
        return self.modifier(
            _ScrollViewConfigurationModifier(item: _ScrollViewConfigurationItem(keyPath: keyPath, value: value))
        )
    }
}
