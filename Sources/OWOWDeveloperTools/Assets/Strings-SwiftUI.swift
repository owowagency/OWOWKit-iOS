import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Text {
    
    public static var propertyTitle: PropertytitleStringsNamespace.Type { PropertytitleStringsNamespace.self }
    public struct PropertytitleStringsNamespace {
        public static var appName: Text { Text("propertyTitle.appName", bundle: .module) }
        public static var buildNumber: Text { Text("propertyTitle.buildNumber", bundle: .module) }
        public static var versionNumber: Text { Text("propertyTitle.versionNumber", bundle: .module) }
        public static var accessibilityEnabled: Text { Text("propertyTitle.accessibilityEnabled", bundle: .module) }
        public static var legibilityWeight: Text { Text("propertyTitle.legibilityWeight", bundle: .module) }
        public static var colorScheme: Text { Text("propertyTitle.colorScheme", bundle: .module) }
        public static var colorSchemeContrast: Text { Text("propertyTitle.colorSchemeContrast", bundle: .module) }
        public static var displayScale: Text { Text("propertyTitle.displayScale", bundle: .module) }
        public static var sizeCategory: Text { Text("propertyTitle.sizeCategory", bundle: .module) }
    }
    
    public static var propertyValue: PropertyvalueStringsNamespace.Type { PropertyvalueStringsNamespace.self }
    public struct PropertyvalueStringsNamespace {
        public static var unknown: Text { Text("propertyValue.unknown", bundle: .module) }
    }
    
    public static var screenTitle: ScreentitleStringsNamespace.Type { ScreentitleStringsNamespace.self }
    public struct ScreentitleStringsNamespace {
        public static var developerMenu: Text { Text("screenTitle.developerMenu", bundle: .module) }
    }
    
    public static var storybook: StorybookStringsNamespace.Type { StorybookStringsNamespace.self }
    public struct StorybookStringsNamespace {
        
        public static var menu: MenuStringsNamespace.Type { MenuStringsNamespace.self }
        public struct MenuStringsNamespace {
            public static var title: Text { Text("storybook.menu.title", bundle: .module) }
            public static var groups: Text { Text("storybook.menu.groups", bundle: .module) }
            public static var stories: Text { Text("storybook.menu.stories", bundle: .module) }
        }
        
        public static var story: StoryStringsNamespace.Type { StoryStringsNamespace.self }
        public struct StoryStringsNamespace {
            
            public static var sections: SectionsStringsNamespace.Type { SectionsStringsNamespace.self }
            public struct SectionsStringsNamespace {
                public static var renderedComponent: Text { Text("storybook.story.sections.renderedComponent", bundle: .module) }
                public static var arguments: Text { Text("storybook.story.sections.arguments", bundle: .module) }
                public static var settings: Text { Text("storybook.story.sections.settings", bundle: .module) }
            }
            public static var unsupportedOsVersion: Text { Text("storybook.story.unsupportedOsVersion", bundle: .module) }
        }
        public static func unsupportedType(_ placeholder0: String) -> Text {
            let format = NSLocalizedString("storybook.unsupportedType", comment: "")
            let string = String(format: format, placeholder0)
            return Text(verbatim: string)
        }
        static func unsupportedType(_ placeholder0: Text) -> Text {
            let format = NSLocalizedString("storybook.unsupportedType", comment: "")
            let temporaryString = String(format: format, "⚠️OWOWGENERATE PLACEHOLDER 0⚠️")
            guard let placeholder0Range = temporaryString.range(of: "⚠️OWOWGENERATE PLACEHOLDER 0⚠️") else {
                fatalError("Placeholder 0 not found in string")
            }
            
            /// Construct the first part of the text view, consisting of the static first portion until the first placeholder + the value for the first placeholder
            var text = Text(verbatim: String(temporaryString[temporaryString.startIndex..<placeholder0Range.lowerBound])) + placeholder0
            text = text + Text(verbatim: String(temporaryString[placeholder0Range.upperBound..<temporaryString.endIndex]))
            return text
        }
    }
    public static var cancelButton: Text { Text("cancelButton", bundle: .module) }
    public static var deeplinks: Text { Text("deeplinks", bundle: .module) }
}