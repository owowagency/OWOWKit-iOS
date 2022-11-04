import Foundation

/// A CodingKey that holds a String key.
public struct AnyCodingKey: CodingKey {
    public var stringValue: String
    
    public var intValue: Int? {
        Int(stringValue)
    }
    
    public init?(intValue: Int) {
        stringValue = String(intValue)
    }
    
    public init(stringValue: String) {
        self.stringValue = stringValue
    }
}
