import Foundation

public extension OperationState {
    /// Evaluates the given closure when this `OperationState` instance is finished, passing the result value as a parameter.
    ///
    /// - returns: If this `OperationState` instance is finished, a new operation state with the result of the executed `transform`.
    func map<T>(_ transform: (Result) -> T) -> OperationState<T, Failure> {
        switch self {
        case .normal: return .normal
        case .inProgress: return .inProgress
        case .finished(let result): return .finished(transform(result))
        case .error(let error): return .error(error)
        }
    }
}
