import SwiftUI

/// This extension contains navigation helpers for programmatic navigation using a binding, so you don't have to `NavigationLink(...) { EmptyView() }` as much.
extension View {
    /// Creates a navigation link that presents the destination view when
    /// a bound selection variable equals a given tag value.
    /// - Parameters:
    ///   - tag: The value of `selection` that causes the link to present
    ///   `destination`.
    ///   - selection: A bound variable that causes the link to present
    ///   `destination` when `selection` becomes equal to `tag`.
    ///   - destination: A view for the navigation link to present.
    public func navigation<V, Destination>(
        tag: V,
        selection: Binding<V?>,
        @ViewBuilder destination: () -> Destination
    ) -> some View where V: Hashable, Destination: View {
        background(
            NavigationLink(
                tag: tag,
                selection: selection,
                destination: destination
            ) { EmptyView() }
        )
    }
    
    /// Creates a navigation link that presents the destination view when active.
    /// - Parameters:
    ///   - isActive: A binding to a Boolean value that indicates whether
    ///   `destination` is currently presented.
    ///   - destination: A view for the navigation link to present.
    public func navigation<Destination>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View where Destination: View {
        background(
            NavigationLink(
                isActive: isActive,
                destination: destination
            ) { EmptyView() }
                .hidden()
        )
    }
    
    /// Creates a navigation link that presents a dynamic destination view when the bound `selection` is not `nil`.
    /// - Parameters:
    ///   - selection: A binding to a selection value that is used for presenting the view.
    ///   - destination: A closure that generates views to present for any given `selection`.
    @available(iOS 14.0, *)
    public func navigation<Selection, Destination>(
        selection: Binding<Selection?>,
        @ViewBuilder destination: @escaping (Selection) -> Destination
    ) -> some View where Destination: View, Selection: Hashable {
        background(
            _NavigationLink(selection: selection, destination: destination)
        )
    }
}

/// A helper struct to capture state for parametric navigation.
@available(iOS 14.0, *)
fileprivate struct _NavigationLink<Selection, Destination>: View where Destination: View, Selection: Equatable {
    @Binding
    var selection: Selection?
    
    var destination: (Selection) -> Destination
    
    @State
    var currentNavigation: Selection?
    
    @State
    var isActive = false
    
    var body: some View {
        navigationLink
            .onChange(of: selection) { selection in
                if selection != nil, currentNavigation != selection {
                    isActive = false
                    currentNavigation = selection
                }
            }
    }
    
    @ViewBuilder
    private var navigationLink: some View {
        if let currentNavigation = currentNavigation {
            NavigationLink(
                isActive: $isActive,
                destination: {
                    destination(currentNavigation)
                        .onDisappear {
                            if selection == nil {
                                self.currentNavigation = nil
                            }
                        }
                },
                label: { EmptyView() }
            )
            .onAppear {
                isActive = true
            }
        }
    }
}
