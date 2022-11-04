import SwiftUI

/// A rectangular shape with some rounded corners, aligned inside the frame
/// of the view containing it.
public struct PartiallyRoundedRectangle: Shape {
    /// The size of the corners, in points.
    public var cornerSize: CGFloat
    
    /// The corners to round.
    public var corners: UIRectCorner
    
    /// 🌷
    /// - Parameters:
    ///   - cornerSize: The size of the corners, in points.
    ///   - corners: The corners to round
    @inlinable
    public init(cornerSize: CGFloat, corners: UIRectCorner) {
        self.cornerSize = cornerSize
        self.corners = corners
    }
    
    public func path(in rect: CGRect) -> Path {
        let radii = CGSize(width: cornerSize, height: cornerSize)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        return Path(path.cgPath)
    }
}

/// View modifier which clips a view to the partially rounded rectangle
public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(PartiallyRoundedRectangle(cornerSize: radius, corners: corners))
    }
}
