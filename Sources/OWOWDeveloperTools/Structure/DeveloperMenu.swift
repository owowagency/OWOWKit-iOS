import SwiftUI

/// A developer menu that hosts developer tools. Designed to be presented in a sheet.
public struct DeveloperMenu: View {
    @ObservedObject var state = DeveloperMenuState()
    
    /// Apps can register URLs here which are made available in the developer menu to quickly deeplink into the app.
    public static var deeplinkURLs = [String: URL?]()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            MainMenu()
        }
        .accentColor(state.accentColor)
        .environmentObject(state)
    }
}

struct DeveloperMenu_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperMenu()
    }
}
