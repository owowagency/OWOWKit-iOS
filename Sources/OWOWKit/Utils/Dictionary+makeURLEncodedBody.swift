import Foundation

public extension Dictionary where Key == String, Value == String {
    /// Converts the dictionary to a `Data` suitable for use as a URLRequest body with a `Content-Type` of `application/x-www-form-urlencoded; charset=utf-8`.
    func makeURLEncodedBody() -> Data {
        var characterSet: CharacterSet = .alphanumerics
        characterSet.formUnion(CharacterSet(charactersIn: "-._*"))
        
        let parameters = map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: characterSet) ?? "")" }
        
        return Data(parameters.joined(separator: "&").utf8)
    }
}
