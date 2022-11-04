import Combine

/// The protocol your app context type must conform to to.
@available(tvOS, unavailable)
public protocol AppContextProtocol: AnyObject {
    /// The UI environment of your app.
    var uiEnvironment: UIEnvironment { get }
}
