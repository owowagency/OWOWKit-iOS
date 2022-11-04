import SwiftUI

public protocol StoryArguments {
    var arguments: [String: PartialKeyPath<Self>] { get }
    
    func isDisabled(keyPath: PartialKeyPath<Self>) -> Bool
}

extension StoryArguments {
    public func isDisabled(keyPath: PartialKeyPath<Self>) -> Bool {
        return false
    }
}
