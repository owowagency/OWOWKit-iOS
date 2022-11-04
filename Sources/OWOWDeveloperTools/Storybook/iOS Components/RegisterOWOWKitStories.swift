import SwiftUI

func registerOWOWKitStories() {
    StoryProvider.register(DatePickerStory(), ToggleStory())
    
    if #available(iOS 14.0, *) {
        StoryProvider.register(ColorPickerStory())
    }
}
