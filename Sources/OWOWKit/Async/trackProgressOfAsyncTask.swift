import Combine
import SwiftUI

/// Execute the given async `task` and write updates about the progress of the task to the given `binding`.
///
/// This is the throwing version of the method.
///
/// This method is useful for launching async tasks from a SwiftUI view and providing feedback to the user. For example, consider the following snippets:
///
/// ```
/// @State
/// var logoutProgress: ProgressState = .normal
///
/// // in `var body`
/// Button(action: { trackProgressOfAsyncTask(to: $logoutProgress, task: logout) }) {
///   ...
/// }
///
/// func logout() async throws { ... }
/// ```
@available(*, deprecated, renamed: "OperationState.track")
public func trackProgressOfAsyncTask<T>(
    to binding: Binding<OperationState<T, Error>>,
    task: @escaping () async throws -> T
) {
    OperationState.track(to: binding, task: { try await task() })
}

/// Execute the given async `task` and write updates about the progress of the task to the given `binding`.
///
/// This is the non-throwing version of the method.
///
/// This method is useful for launching async tasks from a SwiftUI view and providing feedback to the user. For example, consider the following snippets:
///
/// ```
/// @State
/// var logoutProgress: ProgressState = .normal
///
/// // in `var body`
/// Button(action: { trackProgressOfAsyncTask(to: $logoutProgress, task: logout) }) {
///   ...
/// }
///
/// func logout() async throws { ... }
/// ```
@available(*, deprecated, renamed: "OperationState.track")
public func trackProgressOfAsyncTask<T>(
    to binding: Binding<OperationState<T, Never>>,
    task: @escaping () async -> T
) {
    OperationState.track(to: binding, task: { await task() })
}

@available(iOS, introduced: 14, deprecated: 14, renamed: "OperationState.track")
public func trackProgressOfAsyncTask<T>(
    to published: inout Published<OperationState<T, Error>>.Publisher,
    task: @escaping () async throws -> T
) {
    OperationState.track(to: &published, task: { try await task() })
}
