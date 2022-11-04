import Combine

extension Publisher {
    /// Returns the first published element, or `nil` if no element was published before completing.
    public var first: Output? {
        get async throws {
            typealias Continuation = CheckedContinuation<Output?, Error>
            var cancellables = Set<AnyCancellable>()
            
            let result = try await withCheckedThrowingContinuation { (continuation: Continuation) in
                var continuation: CheckedContinuation<Output?, Error>? = continuation
                
                self.first()
                    .sink(
                        receiveCompletion: { completion in
                            switch completion {
                            case .failure(let error):
                                continuation?.resume(throwing: error)
                            case .finished:
                                continuation?.resume(returning: nil)
                            }
                            continuation = nil
                        },
                        receiveValue: { value in
                            continuation?.resume(returning: value)
                            continuation = nil
                        }
                    )
                    .store(in: &cancellables)
            }
            
            /// Swift makes no guarantee on the lifetime of local variables, so we call `removeAll` to make sure the cancellables stay alive at least until this point.
            cancellables.removeAll()
            
            return result
        }
    }
}
