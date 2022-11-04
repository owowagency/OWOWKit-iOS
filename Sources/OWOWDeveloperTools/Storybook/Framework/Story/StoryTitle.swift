import SwiftUI

public struct StoryTitle: ExpressibleByStringLiteral, ExpressibleByArrayLiteral {
    public var elements: [Element]
    
    public init(stringLiteral value: StringLiteralType) {
        self.elements = [Element(stringLiteral: value)]
    }
    
    public init(arrayLiteral elements: Element...) {
        self.elements = elements
    }
    
    public init(elements: [Element]) {
        self.elements = elements
    }
    
    public func dropFirst(_ n: Int = 1) -> StoryTitle {
        StoryTitle(elements: Array(self.elements.dropFirst(n)))
    }
}

extension StoryTitle: CustomStringConvertible {
    public struct Element: ExpressibleByStringLiteral {
        var title: String
        
        public init(stringLiteral value: String) {
            self.title = value
        }
    }
    
    public var description: String {
        self.elements.map { $0.title }.joined(separator: "/")
    }
}

extension StoryTitle.Element {
    static var iosDefault: StoryTitle.Element = "iOS Default"
}
