import Foundation

/// A builder-type struct which generates a `Data` suitable for use as `multipart/form-data` HTTP body.
///
/// Example usage:
///
/// ```swift
/// request.body = MultipartFormDataBuilder()
///   .withData(name: "catphoto-1", data: someData, fileName: "pussy.jpg", contentType: "image/jpeg")
///   .withData(name: "catphoto02", data: someData, fileName: "pussy2.jpg", contentType: "image/jpeg")
///   .build()
/// ```
public struct MultipartFormDataBuilder {
    private var body = Data()
    private let boundary = UUID().uuidString
    
    public init() {}
    
    // MARK: - Builder functions
    
    public func withData(named name: String, data: Data, fileName: String, contentType: String) -> Self {
        var copy = self
        copy.addData(named: name, data: data, fileName: fileName, contentType: contentType)
        return copy
    }
    
    public func build() -> (body: Data, boundary: String) {
        return (body, boundary)
    }
    
    // MARK: - Mutating functions
    
    public mutating func addData(named name: String, data: Data, fileName: String, contentType: String) {
        body += makeDataField(named: name, data: data, fileName: fileName, contentType: contentType)
    }
    
    // MARK: - Implementation details
    
    private func makeDataField(named name: String, data: Data, fileName: String, contentType: String) -> Data {
        let header = """
        --\(boundary)\r
        Content-Disposition: form-data; name="\(name)"; filename="\(fileName)"\r
        Content-Type: \(contentType)\r\n\r\n
        """
        
        let footer = "\r\n"
        
        return header.data(using: .utf8)! + data + footer.data(using: .utf8)!
    }
}
