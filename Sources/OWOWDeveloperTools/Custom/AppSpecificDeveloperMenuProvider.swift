import Foundation
import OWOWKit
import SwiftUI

public protocol AppSpecificDeveloperMenuProvider {
    associatedtype AppSpecificMainMenuSections: View
    
    var appSpecificMainMenuSections: AppSpecificMainMenuSections { get }
}

// MARK: - Configuration & Support

extension OWOWKitConfiguration {
    static var appSpecificDeveloperMenuProvider: AnyAppSpecificDeveloperMenuProvider?
    
    public static func setDeveloperMenuProvider<Provider: AppSpecificDeveloperMenuProvider>(_ provider: Provider) {
        appSpecificDeveloperMenuProvider = AnyAppSpecificDeveloperMenuProvider(provider)
    }
}

/// Don't implement this protocol. Implement the methods in AppSpecificDeveloperMenuProvider instead.
struct AnyAppSpecificDeveloperMenuProvider: AppSpecificDeveloperMenuProvider {
    private var mainMenu: () -> AnyView
    
    init<Provider: AppSpecificDeveloperMenuProvider>(_ provider: Provider) {
        mainMenu = {
            provider.appSpecificMainMenuSections
                .erasedToAnyView()
        }
    }
    
    var appSpecificMainMenuSections: AnyView {
        mainMenu()
    }
}
