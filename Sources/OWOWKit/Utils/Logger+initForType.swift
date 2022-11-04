import Foundation
import os

/// Extension for initializing a logger with the object type
@available(iOS 14.0, *)
public extension Logger {
    /// Initializes a custom logger
    /// - Parameters:
    ///   - type: The type of the object initializing the logger
    ///   - additional: Additional description to the category
    ///   - subsystem: Subsystem of the logger
    init(for type: Any.Type, description: String? = nil, subsystem: String = Bundle.main.bundleIdentifier ?? "unknown") {
        if let description = description {
            self.init(subsystem: subsystem, category: "\(type) \(description)")
        } else {
            self.init(subsystem: subsystem, category: "\(type)")
        }
    }
}
