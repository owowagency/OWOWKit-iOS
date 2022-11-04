import Foundation

public struct Response<Body> {
    public var body: Body
    public var rawBody: Data
    public var statusCode: Int
    
    public init(body: Body, rawBody: Data, statusCode: Int) {
        self.body = body
        self.rawBody = rawBody
        self.statusCode = statusCode
    }
}
