import SwiftUI

/// Similar to `NavigationLink`, but with `sheet` presentation.
public struct SheetLink<Label, Content>: View where Label: View, Content: View {
    /// The internal presentation state which is only used if the external binding is not set.
    /// Do not use directly – access `isPresented` or `_isPresented` instead.
    @State
    private var internalIsPresented = false
    
    /// An optional binding to external presentation state. If set, `internalIsPresented` is not used.
    /// Do not use directly – access `isPresented` or `_isPresented` instead.
    private var externalIsPresented: Binding<Bool>?
    
    /// The closure to execute when dismissing the sheet.
    private var onDismiss: (() -> Void)?
    
    /// A closure that returns the content of the sheet.
    private var content: () -> Content
    
    /// A view builder to produce a label describing the `content` to present.
    private var label: Label
    
    /// A binding to the isPresented state that should be used (internal or external).
    private var _isPresented: Binding<Bool> {
        if let externalIsPresented = externalIsPresented {
            return externalIsPresented
        } else {
            return $internalIsPresented
        }
    }
    
    /// `true` if the sheet is currently open.
    private var isPresented: Bool {
        get { _isPresented.wrappedValue }
        nonmutating set { _isPresented.wrappedValue = newValue }
    }
    
    /// Creates a sheet link that presents the content view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that indicates if the sheet that you create in the `content` closure is currently presented.
    ///   - onDismiss: The closure to execute when dismissing the sheet.
    ///   - content: A closure that returns the content of the sheet.
    ///   - label: A view builder to produce a label describing the `content` to present.
    public init(
        isPresented: Binding<Bool>? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder label: () -> Label
    ) {
        self.externalIsPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content
        self.label = label()
    }
    
    public var body: some View {
        Button(action: { isPresented = true }) {
            label
        }
        .sheet(isPresented: _isPresented, onDismiss: onDismiss, content: content)
    }
}
