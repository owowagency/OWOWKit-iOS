import SwiftUI

/// The simplest generic implementation of `UIViewRepresentable`.
public struct RepresentedView<AView: UIView>: UIViewRepresentable {
    
    /// The `UIView` that is presented.
    public var view: AView
    
    /// 🌷
    public init(_ view: AView) {
        self.view = view
    }
    
    public func makeUIView(context: Context) -> AView {
        return view
    }
    
    public func updateUIView(_ uiView: AView, context: Context) { }
    
}
