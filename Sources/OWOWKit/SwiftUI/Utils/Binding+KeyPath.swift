import Foundation
import SwiftUI

public extension Binding {
    /// Create a binding to a given `keyPath` on `target`.
    ///
    /// This is primarily useful for binding to a computed property on a SwiftUI view. You can mark the setter of such a property as `nonmutating` to be able to
    /// get a reference writable key path to it.
    init<Root>(_ keyPath: ReferenceWritableKeyPath<Root, Value>, on target: Root) {
        self.init(
            get: { target[keyPath: keyPath] },
            set: { target[keyPath: keyPath] = $0 }
        )
    }
}
