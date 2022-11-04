import Foundation

extension Task where Failure == Error {
    /// Retries the given `operation` up to `maxRetries` amount of times before failing permanently.
    /// - Parameters:
    ///   - priority: The priority of the task. Pass `nil` to use the priority from `Task.currentPriority`.
    ///   - maxRetries: The maximum amount of retries before permanently failing.
    ///   - retryDelay: The delay between retries.
    ///   - shouldRetry: A closure that determines if a retry should be attempted, based on the error that occured. The default value always allows a retry.
    ///   - operation: The operation to perform.
    /// - Returns: A reference to the task.
    @discardableResult
    public static func retrying(
        priority: TaskPriority? = nil,
        maxRetries: Int,
        retryDelay: TimeInterval = 1,
        shouldRetry: @Sendable @escaping (Error) -> Bool = { _ in true },
        operation: @Sendable @escaping () async throws -> Success
    ) -> Task {
        Task(priority: priority) {
            for _ in 0..<maxRetries {
                do {
                    return try await operation()
                } catch where shouldRetry(error) {
                    try await Task<Never, Never>.sleep(seconds: retryDelay)
                }
            }
            
            return try await operation()
        }
    }
}
