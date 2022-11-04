import SwiftUI

/// A type that can style instances of `OWOWTextField`.
///
/// Example implementation using `EnvironmentObjectReader`:
///
/// ```
/// struct MyOWOWTextFieldStyle: OWOWTextFieldStyle {
///     func makeBody(configuration: OWOWTextFieldConfiguration) -> some View {
///         EnvironmentObjectReader { (foo: Foo) in
///             configuration.content
///                 .textField(\.placeholder, foo.bar)
///                 .textField(\.textColor, .green)
///                 .background(Color.gray)
///         }
///     }
/// }
/// ```
///
/// Use with the `owowTextFieldStyle(...)` modifier.
public protocol OWOWTextFieldStyle {
    
    /// A `View` representing the body of a `OWOWTextField`.
    associatedtype Body: View
    
    func makeBody(configuration: OWOWTextFieldConfiguration) -> Self.Body
    
}

public struct OWOWTextFieldConfiguration {
    
    /// The content of the text field.
    public let content: AnyView
    
    /// `true` if the text field currently has focus.
    public let hasFocus: Bool
    
}

public struct DefaultOWOWTextFieldStyle: OWOWTextFieldStyle {
    
    public func makeBody(configuration: OWOWTextFieldConfiguration) -> some View {
        return configuration.content
    }
    
}

extension View {
    public func owowTextFieldStyle<T: OWOWTextFieldStyle>(_ style: T) -> some View {
        environment(\.owowTextFieldStyle, AnyOWOWTextFieldStyle(style))
    }
}

// MARK: Internal Implementation

internal struct AnyOWOWTextFieldStyle {
    private var _makeBody: (OWOWTextFieldConfiguration) -> AnyView
    
    init<T: OWOWTextFieldStyle>(_ style: T) {
        _makeBody = { style.makeBody(configuration: $0).erasedToAnyView() }
    }
    
    func makeBody(configuration: OWOWTextFieldConfiguration) -> AnyView {
        _makeBody(configuration)
    }
}

internal struct OWOWTextFieldStyleKey: EnvironmentKey {
    typealias Value = AnyOWOWTextFieldStyle
    static let defaultValue = AnyOWOWTextFieldStyle(DefaultOWOWTextFieldStyle())
}

extension EnvironmentValues {
    internal var owowTextFieldStyle: AnyOWOWTextFieldStyle {
        get {
            return self[OWOWTextFieldStyleKey.self]
        }
        set {
            self[OWOWTextFieldStyleKey.self] = newValue
        }
    }
}


