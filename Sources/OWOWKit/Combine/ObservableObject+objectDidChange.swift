import Combine
import Foundation

public struct ObjectDidChangePublisher<ObjectWillChangePublisher: Publisher>: Publisher {
    private let upstream: ObjectWillChangePublisher
    public typealias Output = ObjectWillChangePublisher.Output
    public typealias Failure = ObjectWillChangePublisher.Failure
    
    fileprivate init(upstream: ObjectWillChangePublisher) {
        self.upstream = upstream
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        self.upstream
            .receive(on: DispatchQueue.main) /// This essentially just delays the publisher until after the `willSet` property observer. Published property changes must happen on the main thread anyway.
            .receive(subscriber: subscriber)
    }
}

extension ObservableObject {
    public var objectDidChange: ObjectDidChangePublisher<ObjectWillChangePublisher> {
        ObjectDidChangePublisher(upstream: objectWillChange)
    }
}
