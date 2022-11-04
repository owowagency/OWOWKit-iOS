import Foundation

/// Represents a dependency injection container, which stores registrations of services.
public struct DIContainer {
    private enum Injected {
        case instance(Any)
        case constructor((DIContainer) -> Any)
        
        func component(using container: DIContainer) -> Any {
            switch self {
            case .instance(let instance): return instance
            case .constructor(let constructor): return constructor(container)
            }
        }
    }
    
    /// Making the container a singleton
    public static var shared = DIContainer()
    
    private var components: [ObjectIdentifier: Injected] = [:]
    
    /// 🌷
    public init() {}
    
    /// Register an instance for a type
    /// - Parameters:
    ///   - type: the type
    ///   - component: the concrete instance you assign to the type
    public mutating func register<Component>(
        type: Component.Type,
        component: Component
    ) {
        components[ObjectIdentifier(type)] = .instance(component)
    }
    
    /// Register a constructor for a type.
    /// - Parameters:
    ///   - type: The type to register.
    ///   - constructor: A constructor that creates an instance of the type
    public mutating func register<Component>(
        type: Component.Type,
        constructor: @escaping (DIContainer) -> Component
    ) {
        components[ObjectIdentifier(type)] = .constructor(constructor)
    }
    
    /// Get a registered instance for a type
    /// - Parameter type: the type you want to get the registered instance
    /// - Returns: the concrete instance for the type  b
    public func resolve<Component>(type: Component.Type = Component.self) -> Component {
        guard let component = components[ObjectIdentifier(type)]?.component(using: self) as? Component else {
            preconditionFailure("Unregistered component")
        }
        return component
    }
}
