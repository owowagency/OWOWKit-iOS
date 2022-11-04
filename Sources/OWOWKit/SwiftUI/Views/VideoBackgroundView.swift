import SwiftUI

/// A view that plays a video in a loop.
public struct VideoBackgroundView: View {
    
    /// The URL of the video being played.
    let videoURL: URL
    
    var play: Bool?
    
    /// 🌷
    /// - parameter videoURL: The URL of the video being played.
    /// - parameter play: If this is set, the atuoplay behaviour of te player is disabled and it can be controlled by setting `play` to `true` instead.
    public init(videoURL: URL, play: Bool? = nil) {
        self.videoURL = videoURL
        self.play = play
    }
    
    public var body: some View {
        VideoBackgroundViewControllerRepresentable(videoURL: videoURL, play: play)
    }
    
}

/// An implementation detail of `VideoBackgroundView`.
fileprivate struct VideoBackgroundViewControllerRepresentable: UIViewControllerRepresentable {
    
    /// The URL of the video being played.
    let videoURL: URL
    
    let play: Bool?

    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoBackgroundViewControllerRepresentable>) -> VideoBackgroundViewController {
        return VideoBackgroundViewController(videoURL: videoURL)
    }
    
    func updateUIViewController(_ uiViewController: VideoBackgroundViewController, context: UIViewControllerRepresentableContext<VideoBackgroundViewControllerRepresentable>) {
        uiViewController.shouldPlay = play
        uiViewController.update()
    }
    
}

struct VideoBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        VideoBackgroundViewControllerRepresentable(
            videoURL: Bundle.main.url(forResource: "Landing", withExtension: "mp4")!,
            play: nil
        )
    }
}
