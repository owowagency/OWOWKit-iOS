import SwiftUI

@available(iOS 14.0, *)
struct ColorPickerStory: Story {
    struct Arguments: StoryArguments {
        var label: String = "Color picker"
        var supportsOpacity = true
        
        var arguments: [String : PartialKeyPath<Arguments>] = [
            "Label": \.label,
            "Supports Opacity": \.supportsOpacity
        ]
    }
    
    var title: StoryTitle = [.iosDefault, "Color picker"]
    var defaultArguments = Arguments()
    var notes: Text? = Text("Available on iOS 14 and later")
    
    func body(arguments: Arguments) -> some View {
        ColorPicker(arguments.label, selection: .constant(.purple), supportsOpacity: arguments.supportsOpacity)
    }
}
