import Foundation
import Combine

extension URLRequest {
    /// Helper method to initialise a URLRequest.
    ///
    /// Note that the configured base URL is not respected when using this method.
    ///
    /// - parameter request: The OWOWKit request.
    /// - parameter parameters: The URL (query) parameters to use.
    /// - parameter headers: The headers to send.
    /// - parameter criteria: Any OWOWKit criteria that should be applied to the request.
    public init<Request: Requestable>(
        request: Request,
        url: URL,
        headers: [String: String] = [:],
        criteria: CriteriaSet = [],
        encoder: JSONEncoder? = nil,
        comment: String? = nil
    ) throws {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        #if DEBUG
        var description = "⬆️ \(urlRequest.httpMethod ?? "") \(url.absoluteString)"
        if let comment = comment {
            description.insert(contentsOf: " " + comment + ":", at: description.firstIndex(of: " ")!)
        }
        #endif
        
        // Add the body if required
        let body = request.body
        if let body = body as? Data {
            urlRequest.httpBody = body
            
            #if DEBUG
            description += " (raw data body)"
            #endif
        } else if !(body is VoidBody) {
            let encoder = encoder ?? OWOWKitConfiguration.jsonEncoder(for: body)
            urlRequest.httpBody = try encoder.encode(body)
            urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            #if DEBUG
            description += " (JSON encoded)"
            #endif
        }
        
        #if DEBUG
        if let body = urlRequest.httpBody {
            description += " (\(body.count) bytes)"
            print(description)
            
            if let bodyString = String(data: body, encoding: .utf8) {
                print(bodyString)
            }
        } else {
            print(description)
        }
        #endif
        
        // Add headers
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        // Load criteria
        try urlRequest.apply(criteria: criteria)
        
        self = urlRequest
    }
    
    /// Helper method to initialise a URLRequest.
    ///
    /// - parameter request: The OWOWKit request.
    /// - parameter url: The URL string. It will be prefixed by `baseURL`.
    /// - parameter parameters: The URL (query) parameters to use.
    /// - parameter headers: The headers to send.
    /// - parameter baseURL: The base URL to prefix before `url`. By default, the base URL configured in OWOWKit is used.
    /// - parameter criteria: Any OWOWKit criteria that should be applied to the request.
    public init<Request: Requestable>(
        request: Request,
        url: String,
        parameters: [String: String?] = [:],
        headers: [String: String] = [:],
        baseURL: String = OWOWKitConfiguration.baseURL,
        criteria: CriteriaSet = [],
        encoder: JSONEncoder? = nil,
        comment: String? = nil
    ) throws {
        let url = try Self.makeURL(url: url, baseURL: baseURL, parameters: parameters, criteria: criteria)
        try self.init(
            request: request,
            url: url,
            headers: headers,
            criteria: criteria,
            encoder: encoder,
            comment: comment
        )
    }
    
    /// Builds the URL with the given parameters.
    private static func makeURL(
        url: String,
        baseURL: String,
        parameters: [String: String?],
        criteria: CriteriaSet
    ) throws -> URL {
        let fullURLString: String
        if baseURL.isEmpty {
            fullURLString = url
        } else {
            fullURLString = "\(baseURL)/\(url)"
        }
        
        // Construct the request
        guard var components: URLComponents = URLComponents(string: fullURLString) else {
            throw URLRequestError.invalidURL
        }
        
        if parameters.count > 0 {
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        try components.apply(criteria: criteria)
        
        guard let url = components.url else {
            throw URLRequestError.invalidURL
        }
        
        return url
    }
    
}
