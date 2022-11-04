import UIKit
import AVKit

/// A view controller that plays a video in a loop.
public final class VideoBackgroundViewController: UIViewController {
    
    // MARK: State
    
    /// The video player.
    private let player = AVQueuePlayer()
    
    /// The player looper.
    private let looper: AVPlayerLooper
    
    /// The video player layer.
    private lazy var playerLayer = AVPlayerLayer(player: self.player)
    
    /// The external boolean that controls if the player is currently playing. If `nil`, autoplay is enabled.
    var shouldPlay: Bool?
    
    // MARK: Init
    
    /// Initialises a new background video player.
    ///
    /// - parameter url: The URL of the video to play.
    public init(videoURL url: URL) {
        self.player.isMuted = true
        
        let playerItem = AVPlayerItem(url: url)
        self.looper = AVPlayerLooper(player: self.player, templateItem: playerItem)
        
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationWillEnterForeground(notification:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
    }
    
    /// Storyboards are not supported.
    required init?(coder: NSCoder) { nil }
    
    // MARK: Setup
    
    /// Setup the player layer.
    public override func loadView() {
        self.view = UIView()
        
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = view.bounds
        self.view.layer.insertSublayer(playerLayer, at: 0)
    }
    
    /// Update the player layer bounds.
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        playerLayer.frame = view.bounds
    }
    
    // MARK: View Lifecycle
    
    /// Stores wether the video is currently playing.
    ///
    /// This is used in the `applicationWillEnterForeground` and the
    /// `applicationDidEnterBackground` methods.
    private var playingState = false
    
    /// Play the video on appear.
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        update()
        guard shouldPlay == nil else {
            return
        }
        
        playingState = true
        player.play()
    }
    
    /// Pause the video view on disappear.
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        playingState = false
        player.pause()
    }
    
    /// `UIApplication.willEnterForeground` handler.
    @objc private func applicationWillEnterForeground(notification: Notification) {
        if playingState {
            player.play()
        }
    }
    
    /// `UIApplication.didEnterBackground` handler.
    @objc private func applicationDidEnterBackground(notification: Notification) {
        if playingState {
            player.pause()
        }
    }
    
    // MARK: Updating
    
    func update() {
        let isPlaying = player.rate != 0
        
        switch (isPlaying, shouldPlay) {
        case (false, true):
            player.play()
            playingState = true
        case (true, false):
            player.pause()
            playingState = false
        default: break
        }
    }
    
}
