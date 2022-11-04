import Foundation

/// A protocol primarily meant for decodable enums that should be decoded into a default, unknown case if no matches are found.
public protocol DefaultUnknownCase: RawRepresentable {
    static var unknown: Self { get }
}

public extension DefaultUnknownCase where Self: Decodable, RawValue: Decodable {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.unknown
    }
}
