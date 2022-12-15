import Foundation
import Combine

extension URLSession {
    /// A shortcut for creating a URLRequest and then calling `responsePublisher` for it.
    ///
    /// See the OWOWKit URLRequest extension for details about most of the parameters.
    public func request<Request, ResponseBody>(
        request: Request,
        url: String,
        parameters: [String: String?] = [:],
        headers: [String: String] = [:],
        baseURL: String = OWOWKitConfiguration.baseURL,
        criteria: CriteriaSet = [],
        responseBody: ResponseBody.Type = ResponseBody.self,
        options: URLRequestOptions = .init()
    ) -> AnyPublisher<Response<ResponseBody>, Error> where Request: Requestable, ResponseBody: Decodable {
        do {
            let request = try URLRequest(
                request: request,
                url: url,
                parameters: parameters,
                headers: headers,
                baseURL: baseURL,
                criteria: criteria
            )
            
            return self
                .responsePublisher(
                    for: request,
                    responseBody: responseBody,
                    options: options
                )
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    /// Returns a response publisher for the given request.
    ///
    /// - parameter request: The URLRequest to do.
    /// - parameter responseBody: The kind of response body to parse. It can normally be omited, but may be helpful to help the compiler if there is ambiguity.
    public func responsePublisher<ResponseBody: Decodable>(
        for request: URLRequest,
        responseBody: ResponseBody.Type = ResponseBody.self,
        options: URLRequestOptions = .init(),
        decoder: JSONDecoder? = nil
    ) -> AnyPublisher<Response<ResponseBody>, Error> {
        let start = Date()
        
        return self
            .dataTaskPublisher(for: request)
            .tryAsyncMap { data, response in
                try await Self.parseResponse(start: start, data: data, response: response, options: options, decoder: decoder)
            }
            .compactMap { $0 }
            .handleEvents(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    OWOWKitConfiguration.logAPIError?(error, request)
                case .finished:
                    break
                }
            })
            .eraseToAnyPublisher()
    }
    
    /// Executes the given request and asynchronously returns the response.
    public func response<ResponseBody: Decodable>(
        for request: URLRequest,
        responseBody: ResponseBody.Type = ResponseBody.self,
        decoder: JSONDecoder? = nil
    ) async throws -> Response<ResponseBody> {
        do {
            let start = Date()
            
            let data: Data
            let response: URLResponse
            
            if #available(iOS 15, *) {
                (data, response) = try await self.data(for: request, delegate: nil)
            } else {
                // Fallback to combine-based API for iOS 13
                guard let result = try await dataTaskPublisher(for: request).first else {
                    throw URLRequestError.internalInconsistency
                }
                
                (data, response) = result
            }
            
            let parsedResponse: Response<ResponseBody>? = try await Self.parseResponse(
                start: start,
                data: data,
                response: response,
                options: URLRequestOptions(allowEmptyNoContentResponse: false),
                decoder: decoder
            )
            
            /// Without `allowEmptyNoContentResponse`, this unwrap should not be able to fail.
            return parsedResponse!
        } catch {
            OWOWKitConfiguration.logAPIError?(error, request)
            
            throw error
        }
    }
    
    private static func parseResponse<ResponseBody: Decodable>(
        start: Date,
        data: Data,
        response: URLResponse,
        options: URLRequestOptions,
        decoder: JSONDecoder?
    ) async throws -> Response<ResponseBody>? {
        guard let response = response as? HTTPURLResponse else {
            throw URLRequestError.internalInconsistency
        }
        
        #if DEBUG
        let duration = Date().timeIntervalSince(start)
        print("⬇️ \(response.statusCode) \(response.url?.absoluteString ?? "") (\(data.count) bytes, \(duration)s)")
        print(String(data: data, encoding: .utf8) ?? "")
        #endif
        
        guard 200..<300 ~= response.statusCode else {
            try await OWOWKitConfiguration.throwAPIError(response, data)
            
            /// This should not happen: the error throwing function should always throw errors.
            throw URLRequestError.internalInconsistency
        }
        
        // No Content Response
        if options.allowEmptyNoContentResponse && response.statusCode == 204 {
            return nil
        }
        
        let decodedBody: ResponseBody
        
        if let type = ResponseBody.self as? VoidBody.Type {
            // swiftlint:disable:next force_cast
            decodedBody = type.init() as! ResponseBody
        } else if ResponseBody.self == String.self {
            guard let string = String(data: data, encoding: .utf8) else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: [],
                        debugDescription: "OWOWKit expected UTF8 string but didn't find any"
                    )
                )
            }
            
            decodedBody = string as! ResponseBody
        } else {
            let decoder = decoder ?? OWOWKitConfiguration.jsonDecoder(for: ResponseBody.self)
            decodedBody = try decoder.decode(ResponseBody.self, from: data)
        }

        return Response(body: decodedBody, rawBody: data, statusCode: response.statusCode, httpResponse: response)
    }
}
