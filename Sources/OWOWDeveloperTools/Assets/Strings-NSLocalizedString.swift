import Foundation

public enum Strings {
    
    public static var propertyTitle: Propertytitle.Type { Propertytitle.self }
    public struct Propertytitle {
        public static var appName: String { NSLocalizedString("propertyTitle.appName", bundle: .module, comment: "") }
        public static var buildNumber: String { NSLocalizedString("propertyTitle.buildNumber", bundle: .module, comment: "") }
        public static var versionNumber: String { NSLocalizedString("propertyTitle.versionNumber", bundle: .module, comment: "") }
        public static var accessibilityEnabled: String { NSLocalizedString("propertyTitle.accessibilityEnabled", bundle: .module, comment: "") }
        public static var legibilityWeight: String { NSLocalizedString("propertyTitle.legibilityWeight", bundle: .module, comment: "") }
        public static var colorScheme: String { NSLocalizedString("propertyTitle.colorScheme", bundle: .module, comment: "") }
        public static var colorSchemeContrast: String { NSLocalizedString("propertyTitle.colorSchemeContrast", bundle: .module, comment: "") }
        public static var displayScale: String { NSLocalizedString("propertyTitle.displayScale", bundle: .module, comment: "") }
        public static var sizeCategory: String { NSLocalizedString("propertyTitle.sizeCategory", bundle: .module, comment: "") }
    }
    
    public static var propertyValue: Propertyvalue.Type { Propertyvalue.self }
    public struct Propertyvalue {
        public static var unknown: String { NSLocalizedString("propertyValue.unknown", bundle: .module, comment: "") }
    }
    
    public static var screenTitle: Screentitle.Type { Screentitle.self }
    public struct Screentitle {
        public static var developerMenu: String { NSLocalizedString("screenTitle.developerMenu", bundle: .module, comment: "") }
    }
    
    public static var storybook: Storybook.Type { Storybook.self }
    public struct Storybook {
        
        public static var menu: Menu.Type { Menu.self }
        public struct Menu {
            public static var title: String { NSLocalizedString("storybook.menu.title", bundle: .module, comment: "") }
            public static var groups: String { NSLocalizedString("storybook.menu.groups", bundle: .module, comment: "") }
            public static var stories: String { NSLocalizedString("storybook.menu.stories", bundle: .module, comment: "") }
        }
        
        public static var story: Story.Type { Story.self }
        public struct Story {
            
            public static var sections: Sections.Type { Sections.self }
            public struct Sections {
                public static var renderedComponent: String { NSLocalizedString("storybook.story.sections.renderedComponent", bundle: .module, comment: "") }
                public static var arguments: String { NSLocalizedString("storybook.story.sections.arguments", bundle: .module, comment: "") }
                public static var settings: String { NSLocalizedString("storybook.story.sections.settings", bundle: .module, comment: "") }
            }
            public static var unsupportedOsVersion: String { NSLocalizedString("storybook.story.unsupportedOsVersion", bundle: .module, comment: "") }
        }
        public static func unsupportedType(_ placeholder0: String) -> String {
            let format = NSLocalizedString("storybook.unsupportedType", bundle: .module, comment: "")
            return String(format: format, placeholder0)
        }
    }
    public static var cancelButton: String { NSLocalizedString("cancelButton", bundle: .module, comment: "") }
    public static var deeplinks: String { NSLocalizedString("deeplinks", bundle: .module, comment: "") }
}