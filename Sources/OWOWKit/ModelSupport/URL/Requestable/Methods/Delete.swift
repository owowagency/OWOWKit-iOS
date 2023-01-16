public struct Delete<Body: Encodable>: Requestable {
    public let method = HTTPMethod.delete
    public var body: Body
    
    public init(body: Body) {
        self.body = body
    }
}

public extension Delete where Body == VoidBody {
    init() {
        self.body = .init()
    }
}
