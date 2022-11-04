import SwiftUI

public extension View {
    /// Presents a view using a full screen cover on iOS 14 and later, or using a sheet on iOS 13.
    @ViewBuilder
    func fullScreenCoverIfAvailable<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        if #available(iOS 14, *) {
            self.fullScreenCover(
                isPresented: isPresented,
                onDismiss: onDismiss,
                content: content
            )
        } else {
            self.sheet(
                isPresented: isPresented,
                onDismiss: onDismiss,
                content: content
            )
        }
    }
    
    /// Presents a view using a full screen cover on iOS 14 and later, or using a sheet on iOS 13.
    @ViewBuilder
    func fullScreenCoverIfAvailable<Content: View, Item: Identifiable>(
        item: Binding<Item?>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        if #available(iOS 14, *) {
            self.fullScreenCover(
                item: item,
                onDismiss: onDismiss,
                content: content
            )
        } else {
            self.sheet(
                item: item,
                onDismiss: onDismiss,
                content: content
            )
        }
    }
}
