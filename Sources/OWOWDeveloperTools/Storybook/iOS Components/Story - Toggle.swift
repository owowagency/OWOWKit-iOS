import SwiftUI

struct ToggleStory: Story {
    struct Arguments: StoryArguments {
        enum Style: String, CaseIterable, Hashable, CustomArgumentUIRendering {
            case automatic, button, `switch`
                
            @ViewBuilder
            func apply<Content: View>(to view: Content) -> some View {
                switch self {
                case .automatic:
                    view.toggleStyle(.automatic)
                case .button:
                    if #available(iOS 15.0, *) {
                        view.toggleStyle(.button)
                    } else {
                        Text.storybook.story.unsupportedOsVersion
                    }
                case .switch:
                    view.toggleStyle(.switch)
                }
            }
        }
        
        var label: String = "Toggle"
        var style: Style = .automatic
        
        var arguments: [String : PartialKeyPath<Arguments>] = [
            "Label": \.label,
            "Style": \.style
        ]
    }
    
    var title: StoryTitle = [.iosDefault, "Toggle"]
    var defaultArguments = Arguments()
    
    func body(arguments: Arguments) -> some View {
        let toggle = StoryState(initialValue: true) { isOn in
            Toggle(arguments.label, isOn: isOn)
        }
        
        return arguments.style.apply(to: toggle)
    }
}

