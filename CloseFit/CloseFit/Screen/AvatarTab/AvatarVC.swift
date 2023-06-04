//
//  AvatarVC.swift
//  CloseFit
//
//  Created by saint on 2023/05/18.
//

import UIKit
import SnapKit
import Then
import AVKit

class AvatarVC: UIViewController {

    private var player: AVPlayer?
    
    private let topView = UIView().then{
        $0.backgroundColor = .white
    }
    
    private let titleLabel = UILabel().then{
        $0.text = "나의 아바타"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20.adjustedW, weight: .medium)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // 영상 파일 경로
        guard let videoPath = Bundle.main.path(forResource: "avatartab", ofType: "mp4") else {
            return
        }

        let videoURL = URL(fileURLWithPath: videoPath)
        let playerItem = AVPlayerItem(url: videoURL)
        player = AVPlayer(playerItem: playerItem)

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        view.addSubviews([topView, titleLabel])
        topView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }

        // 영상 재생
        player?.play()
        navigationController?.navigationBar.isHidden = true
    }
}
