import SwiftUI

public extension Sequence where Element == Text {
    /// Returns a new `Text` view by concatenating the elements of the sequence, adding the given `separator` between each element.
    ///
    /// - parameter separator: The separator to add between each element. The default separator is an empty `Text` view.
    func joined(separator: Text = Text(verbatim: "")) -> Text {
        let allElements = Array(self)
        
        /// If there aren't at least two elements, there is nothing to join.
        guard allElements.count >= 2 else {
            return allElements.first ?? Text(verbatim: "")
        }
        
        return allElements
            .dropFirst()
            .reduce(allElements[0]) { result, next in result + separator + next }
    }
}
