import Foundation

/// Options to control how OWOWKit handles URL requests.
public struct URLRequestOptions {
    /// Allows the server to respond with an empty 204 "No Content" response.
    ///
    /// This option can be used with a URL that sometimes returns content that needs to be decoded,
    /// mostly with status code 200, but also might return an empty response with status code 204 "No Content".
    ///
    /// When this option is enabled and the server respons with status code 204, the content is not decoded.
    /// Instead, the response publisher just completes without an error, without publishing anything.
    public var allowEmptyNoContentResponse: Bool
    
    /// Memberwise `init`. See individual properties for documentation.
    public init(allowEmptyNoContentResponse: Bool = false) {
        self.allowEmptyNoContentResponse = allowEmptyNoContentResponse
    }
}
