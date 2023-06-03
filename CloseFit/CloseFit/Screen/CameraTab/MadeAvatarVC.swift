//
//  ClothVideo.swift
//  CloseFit
//
//  Created by saint on 2023/06/01.
//
import UIKit
import SnapKit
import Then

class MadeAvatarVC: UIViewController {

    private let avatarImage = UIImageView().then {
        $0.image = UIImage(named: "avatarImage")
        $0.contentMode = .scaleToFill
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        addTapGesture()
    }
    
    private func setLayout(){
        view.addSubview(avatarImage)
        avatarImage.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("DismissModalView"), object: nil, userInfo: nil)
    }
}

