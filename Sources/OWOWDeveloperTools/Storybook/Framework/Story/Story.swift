import SwiftUI

public protocol Story {
    associatedtype Arguments: StoryArguments
    associatedtype Body: View
    
    var title: StoryTitle { get }
    var defaultArguments: Arguments { get }
    var notes: Text? { get }
    
    func body(arguments: Arguments) -> Body
}

public extension Story {
    var notes: Text? { nil }
}
