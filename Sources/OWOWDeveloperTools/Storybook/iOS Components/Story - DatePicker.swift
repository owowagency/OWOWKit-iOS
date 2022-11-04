import SwiftUI

struct DatePickerStory: Story {
    struct Arguments: StoryArguments {
        enum Style: String, CaseIterable, Hashable, CustomArgumentUIRendering {
            case `default`, compact, graphical, wheel
            
            @ViewBuilder
            func apply<Content: View>(to view: Content) -> some View {
                switch self {
                case .default:
                    view.datePickerStyle(DefaultDatePickerStyle())
                case .compact:
                    if #available(iOS 14.0, *) {
                        view.datePickerStyle(CompactDatePickerStyle())
                    } else {
                        Text.storybook.story.unsupportedOsVersion
                    }
                case .graphical:
                    if #available(iOS 14.0, *) {
                        view.datePickerStyle(GraphicalDatePickerStyle())
                    } else {
                        Text.storybook.story.unsupportedOsVersion
                    }
                case .wheel:
                    view.datePickerStyle(WheelDatePickerStyle())
                }
            }
        }
        
        enum Components: String, CaseIterable, Hashable, CustomArgumentUIRendering {
            case both, date, hourAndMinute
            
            var components: DatePickerComponents {
                switch self {
                case .both:
                    return [.hourAndMinute, .date]
                case .hourAndMinute:
                    return [.hourAndMinute]
                case .date:
                    return [.date]
                }
            }
        }
        
        var label: String = "Date picker"
        var style: Style = .default
        var components: Components = .both
        
        var arguments: [String : PartialKeyPath<DatePickerStory.Arguments>] = [
            "Label": \.label,
            "Style": \.style,
            "Displayed Components": \.components
        ]
    }
    
    var title: StoryTitle = [.iosDefault, "Date picker"]
    var defaultArguments = Arguments()
    var notes: Text? = Text("Did you know you can use the keyboard to enter a date in the wheel picker style? 🤯")
    
    func body(arguments: Arguments) -> some View {
        let picker = DatePicker(
            arguments.label,
            selection: .constant(Date()),
            displayedComponents: arguments.components.components
        )
        
        return arguments.style.apply(to: picker)
    }
}
