import OWOWKit
import XCTest

fileprivate protocol DIContainerTestProtocol {
    func test() -> String
}

fileprivate class FirstImplementation: DIContainerTestProtocol {
    func test() -> String { "First" }
}

fileprivate class SecondImplementation: DIContainerTestProtocol {
    func test() -> String { "Second" }
}

final class DIContainerTests: XCTestCase {
    func testDIContainer() {
        DIContainer.shared.register(
            type: DIContainerTestProtocol.self,
            component: FirstImplementation()
        )
        
        let implementation = DIContainer.shared.resolve(type: DIContainerTestProtocol.self)
        
        XCTAssertEqual(implementation.test(), "First", "The first implementation should be the one resolved.")
    }
    
    func testDIContainerAutoResolve() {
        DIContainer.shared.register(
            type: DIContainerTestProtocol.self,
            component: FirstImplementation()
        )
        
        let implementation: DIContainerTestProtocol = DIContainer.shared.resolve()
        
        XCTAssertEqual(implementation.test(), "First", "The first implementation should be the one resolved.")
    }
    
    func testDIContainerConstructor() {
        DIContainer.shared.register(
            type: DIContainerTestProtocol.self,
            constructor: { _ in return FirstImplementation() }
        )
        
        let implementation = DIContainer.shared.resolve(type: DIContainerTestProtocol.self)
        
        XCTAssertEqual(implementation.test(), "First", "The first implementation should be the one resolved.")
    }
}
