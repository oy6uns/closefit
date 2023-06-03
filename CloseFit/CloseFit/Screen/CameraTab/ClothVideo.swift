//
//  ClothVideo.swift
//  CloseFit
//
//  Created by saint on 2023/06/01.
//
import UIKit

import AVFoundation

class ClothVideo: UIViewController {
    
    var onCompletion: (() -> Void)?

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        playVideoButtonPressed()
    }
    
    func playVideoButtonPressed() {
        guard let url = Bundle.main.url(forResource: "cloth", withExtension: "mp4") else {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            self.player?.pause()
            self.playerLayer?.removeFromSuperlayer()
            self.dismiss(animated: true)
            self.onCompletion?()
        }
    }
}
