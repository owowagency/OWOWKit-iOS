import UIKit

extension UIApplication {
    /// Returns `true` if the app is downloaded from the app store.
    @available(iOSApplicationExtension, unavailable)
    public static let isDownloadedFromTheAppStore: Bool = {
        guard let receiptURL = Bundle.main.appStoreReceiptURL else {
            return false
        }
        
        return !receiptURL.path.contains("sandboxReceipt") && !receiptURL.path.contains("Library/Developer/CoreSimulator")
    }()
}
