import SwiftUI
import OWOWKit

struct MainMenu: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            NavigationLink(destination: Lazy(StorybookMenu(group: StoryProvider.topLevelGroup))) {
                Text.storybook.menu.title
            }
            
            if !Information.appSpecific.isEmpty {
                Section {
                    AppSpecificInformationFormItems()
                }
            }
            
            if !DeveloperMenu.deeplinkURLs.isEmpty {
                Section(header: Text.deeplinks) {
                    DeeplinksView(dismiss: dismiss)
                }
            }
            
            OWOWKitConfiguration.appSpecificDeveloperMenuProvider?
                .appSpecificMainMenuSections
            
            Section {
                EnvironmentSummaryFormItems()
            }
            
            Section(footer: Image.owowLogo100.frame(maxWidth: .infinity).foregroundColor(.primary)) {
                AppDetailsSummaryFormItems()
            }
        }
        .navigationBarTitle(Text.screenTitle.developerMenu)
        .navigationBarItems(leading: closeButton)
    }
    
    private var closeButton: some View {
        Button(action: dismiss) {
            Text.cancelButton
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
