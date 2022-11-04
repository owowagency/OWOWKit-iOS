import Combine

extension Publishers {
    public struct TryAsyncMap<Upstream, Output>: Publisher where Upstream: Publisher {
        public typealias Failure = Error
        
        private let innerPublisher: FlatMap<Future<Output, Error>, MapError<Upstream, Error>>
        
        public init(upstream: Upstream, transform: @escaping (Upstream.Output) async throws -> Output) {
            innerPublisher = upstream
                .mapError { $0 as Error }
                .flatMap { upstreamOutput in
                    Future {
                        try await transform(upstreamOutput)
                    }
                }
        }
        
        public func receive<S>(subscriber: S) where S : Subscriber, Error == S.Failure, Output == S.Input {
            innerPublisher.receive(subscriber: subscriber)
        }
    }
}

extension Publisher {
    /// Transforms all elements from the upstream publisher with a provided asynchronous error-throwing closure.
    public func tryAsyncMap<T>(_ transform: @escaping (Output) async throws -> T) -> Publishers.TryAsyncMap<Self, T> {
        Publishers.TryAsyncMap(upstream: self, transform: transform)
    }
}
