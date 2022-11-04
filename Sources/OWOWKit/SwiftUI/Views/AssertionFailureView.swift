import SwiftUI

/// A view for handling cases which should not happen and where in normal code, you would want to handle using an `assertionFailure`.
/// See the documentation on `assertionFailure` for details.
public struct AssertionFailureView: View {
    public init(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        assertionFailure(message(), file: file, line: line)
    }
    
    public var body: some View {
        EmptyView()
    }
}
