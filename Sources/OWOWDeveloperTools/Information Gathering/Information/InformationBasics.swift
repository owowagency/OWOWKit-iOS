import Foundation

extension Information {
    struct AppName: InformationGathering {
        var title = Strings.propertyTitle.appName
        
        func gatherInfo() -> String? {
            Bundle.main.infoDictionary?["CFBundleName"] as? String
        }
    }
    
    struct VersionNumber: InformationGathering {
        var title = Strings.propertyTitle.versionNumber
        
        func gatherInfo() -> String? {
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        }
    }
    
    struct BuildNumber: InformationGathering {
        var title = Strings.propertyTitle.buildNumber
        
        func gatherInfo() -> String? {
            Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        }
    }
}
