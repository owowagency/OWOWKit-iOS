import Combine

extension Future where Failure == Error {
    public convenience init(_ action: @escaping () async throws -> Output) {
        self.init { promise in
            Task.init {
                do {
                    promise(.success(try await action()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}

extension Future where Failure == Never {
    public convenience init(_ taskPriority: TaskPriority? = nil, _ action: @escaping () async -> Output) {
        self.init { promise in
            Task(priority: taskPriority) {
                promise(.success(await action()))
            }
        }
    }
}

