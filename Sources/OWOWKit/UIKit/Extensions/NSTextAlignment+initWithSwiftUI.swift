import SwiftUI
import UIKit

extension NSTextAlignment {
    public init(_ textAlignment: TextAlignment) {
        switch textAlignment {
        case .leading:
            self = .left
        case .center:
            self = .center
        case .trailing:
            self = .right
        }
    }
}
