import SwiftUI

struct StorybookMenu: View {
    var group: StoryGroup
    
    var body: some View {
        Form {
            if !group.subgroups.isEmpty {
                Section(header: Text.storybook.menu.groups) {
                    ForEach(group.subgroups) { subgroup in
                        NavigationLink(destination: StorybookMenu(group: subgroup)) {
                            Text(subgroup.title ?? "")
                        }
                    }
                }
            }
            
            if !group.stories.isEmpty {
                Section(header: Text.storybook.menu.stories) {
                    ForEach(group.stories) { story in
                        NavigationLink(destination: story.getStoryView()) {
                            Text(story.title.dropFirst(group.nestingLevel).description)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(
            group.title.map { Text($0) } ??
            Text.storybook.menu.title
        )
    }
}
