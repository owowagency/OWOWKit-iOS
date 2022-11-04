import SwiftUI

/// A type-erased story.
struct IndexedStory: Identifiable {
    private var _getStoryView: () -> AnyView
    private var _getStoryTitle: () -> StoryTitle
    let id = UUID()
    
    init<S: Story>(_ story: S) {
        _getStoryView = {
            StoryView(story: story)
                .erasedToAnyView()
        }
        
        _getStoryTitle = {
            story.title
        }
    }
    
    var title: StoryTitle {
        _getStoryTitle()
    }
    
    func getStoryView() -> some View {
        _getStoryView()
    }
}

