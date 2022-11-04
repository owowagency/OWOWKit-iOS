import Combine
import SwiftUI

public extension OperationState {
    /// Execute the given async `task` and write updates about the progress of the task to the given `binding`.
    ///
    /// This is the throwing version of the method.
    ///
    /// This method is useful for launching async tasks from a SwiftUI view and providing feedback to the user. For example, consider the following snippets:
    ///
    /// ```
    /// @State
    /// var logoutProgress = ProgressState()
    ///
    /// // in `var body`
    /// Button(action: { ProgressState.track(to: $logoutProgress, task: logout) }) {
    ///   ...
    /// }
    ///
    /// func logout() async throws { ... }
    /// ```
    @discardableResult
    static func track(
        to binding: Binding<Self>,
        task: @escaping @Sendable () async throws -> Result
    ) -> Task<Result, Error> where Failure == Error {
        Task { @MainActor in
            binding.wrappedValue = .inProgress
            
            do {
                let result = try await task()
                binding.wrappedValue = .finished(result)
                return result
            } catch {
                binding.wrappedValue = .error(error)
                throw error
            }
        }
    }
    
    /// Execute the given async `task` and write updates about the progress of the task to the given `binding`.
    ///
    /// This is the non-throwing version of the method.
    ///
    /// This method is useful for launching async tasks from a SwiftUI view and providing feedback to the user. For example, consider the following snippets:
    ///
    /// ```
    /// @State
    /// var logoutProgress = ProgressState()
    ///
    /// // in `var body`
    /// Button(action: { ProgressState.track(to: $logoutProgress, task: logout) }) {
    ///   ...
    /// }
    ///
    /// func logout() async throws { ... }
    /// ```
    @discardableResult
    static func track(
        to binding: Binding<Self>,
        task: @escaping @Sendable () async -> Result
    ) -> Task<Result, Never> where Failure == Never {
        Task { @MainActor in
            binding.wrappedValue = .inProgress
            let result = await task()
            binding.wrappedValue = .finished(result)
            return result
        }
    }

    /// A version of `OperationState.track` that tracks it's progress to a published property instead of a binding, using `Publisher.assign(to: ...)`.
    @discardableResult
    @available(iOS 14, *)
    static func track(
        to published: inout Published<OperationState<Result, Failure>>.Publisher,
        task: @escaping @Sendable () async throws -> Result
    ) -> Task<Result, Error> where Failure == Error {
        let task = Task {
            return try await task()
        }
        
        Future {
            try await task.value
        }
        .convertToOperationState()
        .receive(on: DispatchQueue.main)
        .assign(to: &published)
        
        return task
    }
}
