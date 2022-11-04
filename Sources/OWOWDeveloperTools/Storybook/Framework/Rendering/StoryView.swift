import SwiftUI

struct StoryView<Content: Story>: View {
    @State var arguments: Content.Arguments
    @State var hideFormLabels = false
    @EnvironmentObject var state: DeveloperMenuState
    
    var story: Content
    
    init(story: Content) {
        self.story = story
        self._arguments = State(initialValue: story.defaultArguments)
    }
    
    var body: some View {
        Form {
            Section(header: Text.storybook.story.sections.renderedComponent) {
                storyBody
                
                NavigationLink("Display full-screen") {
                    storyBody
                }
            }
            
            Section(header: Text.storybook.story.sections.arguments) {
                ForEach(Array(arguments.arguments.sorted(by: { $0.key < $1.key })), id: \.key) { key, keyPath in
                    StoryArgumentView(target: $arguments, name: key, keyPath: keyPath)
                        .disabled(arguments.isDisabled(keyPath: keyPath))
                }
            }
            
            Section(header: Text.storybook.story.sections.settings) {
                settings
            }
            
            if let notes = story.notes {
                Section(header: Text("Notes"), footer: notes) {}
            }
        }
        .navigationBarTitle(story.title.elements.last?.title ?? "Story")
    }
    
    @ViewBuilder
    var settings: some View {
        if #available(iOS 14.0, *) {
            HStack {
                ColorPicker("Accent Color", selection: $state.accentColor)
                
                if state.accentColor != .accentColor {
                    Button(action: { state.accentColor = .accentColor }) {
                        Text("Reset")
                    }
                }
            }
        }
        
        Toggle("Hide form labels", isOn: $hideFormLabels)
    }
    
    var storyBody: some View {
        story.body(arguments: arguments)
            .if(hideFormLabels) {
                $0.labelsHidden()
            }
    }
}

extension ColorScheme: CustomArgumentUIRendering {}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StoryView(story: DatePickerStory())
        }
    }
}

