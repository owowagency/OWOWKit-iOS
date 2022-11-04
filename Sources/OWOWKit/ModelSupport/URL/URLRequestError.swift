import Foundation

public enum URLRequestError: Error, LocalizedError, CustomStringConvertible, CustomNSError {
    case internalInconsistency
    case errorThrowingFunctionNotAssigned
    case serverErrorAndUnableToDecodeErrorBody(HTTPURLResponse, Error)
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
        case .internalInconsistency:
            return "Internal inconsistency"
        case .errorThrowingFunctionNotAssigned:
            return "Error throwing function not assigned"
        case .serverErrorAndUnableToDecodeErrorBody(let response, let error):
            return "Server responded with \(response.statusCode) – unable to decode error: \(error.localizedDescription)"
        case .invalidURL:
            return "The URL is invalid"
        }
    }
    
    public var description: String {
        return "OWOWKit.URLRequestError: \(self.localizedDescription)"
    }
    
    public var underlyingError: Error? {
        switch self {
        case .serverErrorAndUnableToDecodeErrorBody(_, let error): return error
        default: return nil
        }
    }
    
    public var errorUserInfo: [String : Any] {
        return (underlyingError as NSError?)?.userInfo ?? ["description": errorDescription ?? "nil"]
    }
    
    public static var errorDomain: String {
        return "OWOWKitError"
    }
    
    public var errorCode: Int {
        if let underlyingCode = (underlyingError as NSError?)?.code {
            return underlyingCode
        }
        
        switch self {
        case .internalInconsistency: return 4
        case .errorThrowingFunctionNotAssigned: return 5
        case .serverErrorAndUnableToDecodeErrorBody: return 6
        case .invalidURL: return 7
        }
    }
}
