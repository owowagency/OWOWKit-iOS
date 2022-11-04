import SwiftUI

struct StoryGroup: Identifiable {
    /// The title of the group, if any.
    let title: String?
    let nestingLevel: Int
    let stories: [IndexedStory]
    let subgroups: [StoryGroup]
    let id = UUID()
    
    init(nestingLevel: Int, stories: [IndexedStory], title: String?) {
        self.title = title
        self.nestingLevel = nestingLevel
        
        // First, divide the stories into top-level and subgrouped.
        var subgroups = [String: [IndexedStory]]()
        var topLevelStories = [IndexedStory]()
        
        for story in stories {
            let adjustedTitle = story.title.dropFirst(nestingLevel)
            
            if adjustedTitle.elements.count >= 2 { // Still nested, so group needed.
                let groupName = adjustedTitle.elements[0]
                var groupStories = subgroups[groupName.title] ?? []
                groupStories.append(story)
                subgroups[groupName.title] = groupStories
            } else {
                topLevelStories.append(story)
            }
        }
        
        // Next, construct the groups
        self.subgroups = subgroups
            .map { (title, stories) in
                StoryGroup(
                    nestingLevel: nestingLevel + 1,
                    stories: stories,
                    title: title
                )
            }
            .sorted(by: { $0.title! < $1.title! })
        
        self.stories = topLevelStories
            .sorted(by: { $0.title.description < $1.title.description })
    }
}
