import Combine
import SwiftUI

@available(iOS 15.0, *)
extension OperationState where Failure == Error {
    static func run(priority: TaskPriority? = nil, state: Binding<Self>, action: @escaping () async throws -> Result) {
        Task.init(priority: priority) {
            state.wrappedValue = .inProgress

            do {
                state.wrappedValue = .finished(try await action())
            } catch {
                state.wrappedValue = .error(error)
            }
        }
    }
}

@available(iOS 15.0, *)
extension OperationState where Failure == Never {
    static func run(priority: TaskPriority? = nil, state: Binding<Self>, action: @escaping () async -> Result) {
        Task.init(priority: priority) {
            state.wrappedValue = .inProgress

            state.wrappedValue = .finished(await action())
        }
    }
}

