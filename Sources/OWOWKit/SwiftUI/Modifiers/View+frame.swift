import SwiftUI

extension View {
    public func frame(_ size: CGSize, alignment: Alignment = .center) -> some View{
        self.frame(width: size.width, height: size.height, alignment: alignment)
    }
}
