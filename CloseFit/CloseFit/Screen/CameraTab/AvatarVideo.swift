//
//  ClothVideo.swift
//  CloseFit
//
//  Created by saint on 2023/06/01.
//
import UIKit
import SnapKit
import Then

import AVFoundation

class AvatarVideo: UIViewController {
    
    var onCompletion: (() -> Void)?
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        playVideoButtonPressed()
    }
    
    func playVideoButtonPressed() {
        guard let url = Bundle.main.url(forResource: "avatar", withExtension: "mp4") else {
            print("Video not found")
            return
        }
        
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.view.bounds
        if let playerLayer = playerLayer {
            self.view.layer.addSublayer(playerLayer)
        }
        
        player?.play()
//
//        let duration = CMTimeGetSeconds(player?.currentItem?.duration ?? CMTime.zero)
//        let playbackDuration = 4.0 // 재생 시간을 4초로 설정
//        let timeRemaining = duration - playbackDuration
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 40.0) { [weak self] in
            self?.videoPlaybackDidFinish()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoPlaybackDidFinish), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc private func videoPlaybackDidFinish() {
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                
                self.onCompletion?()
            }
        }
    }
}
