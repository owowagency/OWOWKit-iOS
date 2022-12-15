import Foundation

public struct Response<Body> {
    public var body: Body
    public var rawBody: Data
    public var statusCode: Int
    public var httpResponse: HTTPURLResponse
    
    public init(body: Body, rawBody: Data, statusCode: Int, httpResponse: HTTPURLResponse) {
        self.body = body
        self.rawBody = rawBody
        self.statusCode = statusCode
        self.httpResponse = httpResponse
    }
}
