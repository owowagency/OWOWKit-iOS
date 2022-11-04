import SwiftUI

@available(iOS 15, *)
public extension View {
    /// Adds an asynchronous task to perform when this view appears.
    ///
    /// Compared to the normal `task` modifier, this variant keeps track of the progress of the task in an `OperationState` binding.
    ///
    /// Refer to the documentation of Apple's `task` modifier for more information, such as cancellation behavior.
    func task<Result>(
        priority: TaskPriority = .userInitiated,
        state: Binding<OperationState<Result, Error>>,
        _ action: @escaping () async throws -> Result
    ) -> some View {
        self
            .task {
                state.wrappedValue = .inProgress
                do {
                    state.wrappedValue = .finished(try await action())
                } catch {
                    state.wrappedValue = .error(error)
                }
            }
    }
    
    /// Adds an asynchronous task to perform when this view appears or when a specified value changes.
    ///
    /// Compared to the normal `task` modifier, this variant keeps track of the progress of the task in an `OperationState` binding.
    ///
    /// Refer to the documentation of Apple's `task` modifier for more information, such as cancellation behavior.
    func task<T, Result>(
        id value: T,
        priority: TaskPriority = .userInitiated,
        state: Binding<OperationState<Result, Error>>,
        _ action: @escaping () async throws -> Result
    ) -> some View where T: Equatable {
        self
            .task(id: value) {
                state.wrappedValue = .inProgress
                do {
                    state.wrappedValue = .finished(try await action())
                } catch {
                    state.wrappedValue = .error(error)
                }
            }
    }
}
