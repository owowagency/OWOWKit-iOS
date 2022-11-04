import SwiftUI

/// A view that provides storage for the state of a story.
///
/// Example:
///
/// ```
/// StoryState(initialValue: true) { isOn in
///     Toggle(arguments.label, isOn: isOn)
/// }
/// ```
public struct StoryState<S, Content: View>: View {
    public typealias ContentProvider = (Binding<S>) -> Content
    
    @State
    private var state: S
    
    private var content: ContentProvider
    
    public init(initialValue: S, @ViewBuilder content: @escaping ContentProvider) {
        self._state = State(initialValue: initialValue)
        self.content = content
    }
    
    public var body: some View {
        content($state)
    }
}
