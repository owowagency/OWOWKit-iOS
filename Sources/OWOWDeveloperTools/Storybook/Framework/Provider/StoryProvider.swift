import SwiftUI

public enum StoryProvider {
    static private var _topLevelGroup: StoryGroup?
    static private var _stories = [IndexedStory]() {
        didSet {
            _topLevelGroup = nil
        }
    }
    
    static var topLevelGroup: StoryGroup {
        if let group = _topLevelGroup {
            return group
        }
        
        let group = StoryGroup(nestingLevel: 0, stories: stories, title: nil)
        _topLevelGroup = group
        return group
    }
    
    static var stories: [IndexedStory] {
        get {
            assert(Thread.isMainThread) // The following is not thread safe.
            
            while !pendingRegistrations.isEmpty {
                pendingRegistrations.removeLast()()
            }
            
            return _stories
        }
        set {
            _stories = newValue
        }
    }
    
    // Any stories that still have to be registered.
    static var pendingRegistrations: [() -> Void] = [
        registerOWOWKitStories
    ]
    
    /// Registers stories lazily so they don't slow down the startup of the app.
    public static func registerLazy(_ closure: @escaping () -> Void) {
        pendingRegistrations.append(closure)
    }
    
    public static func register<
        S1: Story
    >(
        _ story1: S1
    ) {
        stories.append(IndexedStory(story1))
    }
    
    public static func register<
        S1: Story,
        S2: Story
    >(
        _ story1: S1,
        _ story2: S2
    ) {
        stories.append(IndexedStory(story1))
        stories.append(IndexedStory(story2))
    }
    
    public static func register<
        S1: Story,
        S2: Story,
        S3: Story
    >(
        _ story1: S1,
        _ story2: S2,
        _ story3: S3
    ) {
        stories.append(IndexedStory(story1))
        stories.append(IndexedStory(story2))
        stories.append(IndexedStory(story3))
    }
    
    public static func register<
        S1: Story,
        S2: Story,
        S3: Story,
        S4: Story
    >(
        _ story1: S1,
        _ story2: S2,
        _ story3: S3,
        _ story4: S4
    ) {
        stories.append(IndexedStory(story1))
        stories.append(IndexedStory(story2))
        stories.append(IndexedStory(story3))
        stories.append(IndexedStory(story4))
    }
    
    public static func register<
        S1: Story,
        S2: Story,
        S3: Story,
        S4: Story,
        S5: Story
    >(
        _ story1: S1,
        _ story2: S2,
        _ story3: S3,
        _ story4: S4,
        _ story5: S5
    ) {
        stories.append(IndexedStory(story1))
        stories.append(IndexedStory(story2))
        stories.append(IndexedStory(story3))
        stories.append(IndexedStory(story4))
        stories.append(IndexedStory(story5))
    }
    
    public static func register<
        S1: Story,
        S2: Story,
        S3: Story,
        S4: Story,
        S5: Story,
        S6: Story
    >(
        _ story1: S1,
        _ story2: S2,
        _ story3: S3,
        _ story4: S4,
        _ story5: S5,
        _ story6: S6
    ) {
        stories.append(IndexedStory(story1))
        stories.append(IndexedStory(story2))
        stories.append(IndexedStory(story3))
        stories.append(IndexedStory(story4))
        stories.append(IndexedStory(story5))
        stories.append(IndexedStory(story6))
    }
    
    public static func register<
        S1: Story,
        S2: Story,
        S3: Story,
        S4: Story,
        S5: Story,
        S6: Story,
        S7: Story
    >(
        _ story1: S1,
        _ story2: S2,
        _ story3: S3,
        _ story4: S4,
        _ story5: S5,
        _ story6: S6,
        _ story7: S7
    ) {
        stories.append(IndexedStory(story1))
        stories.append(IndexedStory(story2))
        stories.append(IndexedStory(story3))
        stories.append(IndexedStory(story4))
        stories.append(IndexedStory(story5))
        stories.append(IndexedStory(story6))
        stories.append(IndexedStory(story7))
    }
    
    public static func register<
        S1: Story,
        S2: Story,
        S3: Story,
        S4: Story,
        S5: Story,
        S6: Story,
        S7: Story,
        S8: Story
    >(
        _ story1: S1,
        _ story2: S2,
        _ story3: S3,
        _ story4: S4,
        _ story5: S5,
        _ story6: S6,
        _ story7: S7,
        _ story8: S8
    ) {
        stories.append(IndexedStory(story1))
        stories.append(IndexedStory(story2))
        stories.append(IndexedStory(story3))
        stories.append(IndexedStory(story4))
        stories.append(IndexedStory(story5))
        stories.append(IndexedStory(story6))
        stories.append(IndexedStory(story7))
        stories.append(IndexedStory(story8))
    }
    
    public static func register<
        S1: Story,
        S2: Story,
        S3: Story,
        S4: Story,
        S5: Story,
        S6: Story,
        S7: Story,
        S8: Story,
        S9: Story
    >(
        _ story1: S1,
        _ story2: S2,
        _ story3: S3,
        _ story4: S4,
        _ story5: S5,
        _ story6: S6,
        _ story7: S7,
        _ story8: S8,
        _ story9: S9
    ) {
        stories.append(IndexedStory(story1))
        stories.append(IndexedStory(story2))
        stories.append(IndexedStory(story3))
        stories.append(IndexedStory(story4))
        stories.append(IndexedStory(story5))
        stories.append(IndexedStory(story6))
        stories.append(IndexedStory(story7))
        stories.append(IndexedStory(story8))
        stories.append(IndexedStory(story9))
    }
}
