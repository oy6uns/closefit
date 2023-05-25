//
//  CameraVC.swift
//  CloseFit
//
//  Created by saint on 2023/05/18.
//

import UIKit
import SnapKit
import Then

class CameraVC: UIViewController {
    
    private let upperLine = UIView().then{
        $0.backgroundColor = .systemGray6
    }
    
    private let middleLine = UIView().then{
        $0.backgroundColor = .systemGray6
    }
    
    private let lowerLine = UIView().then{
        $0.backgroundColor = .systemGray6
    }
    
    private let titleLabel = UILabel().then{
        $0.text = "측정"
        $0.font = .systemFont(ofSize: 20.adjustedW, weight: .medium)
    }
    
    private let clothBtn = UIButton().then {
        $0.backgroundColor = .clear
//        $0.layer.cornerRadius = 25
//        $0.layer.borderWidth = 1.0
//        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .light)
        $0.setTitle("디지털 의류 생성 👕👖", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.isUserInteractionEnabled = true
    }
    
    private let avatarBtn = UIButton().then {
        $0.backgroundColor = .clear
//        $0.layer.cornerRadius = 25
//        $0.layer.borderWidth = 1.0
//        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .light)
        $0.setTitle("3D 아바타 생성🧍🏻🧍🏻‍♀️", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.isUserInteractionEnabled = true
    }
    
    lazy var makeClothVC = MakeClothVC()
    lazy var makeAvatarVC = MakeAvatarVC()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setLayout()
        pressBtn()
    }
    
    private func pressBtn(){
        clothBtn.press { [self] in
            makeClothVC.modalPresentationStyle = .overFullScreen
            self.present(makeClothVC, animated: true, completion:nil)
        }
        
        avatarBtn.press { [self] in
            makeAvatarVC.modalPresentationStyle = .overFullScreen
            self.present(makeAvatarVC, animated: true, completion:nil)
        }
    }
}

extension CameraVC{
    private func setLayout(){
        view.addSubviews([titleLabel, upperLine, middleLine, lowerLine, clothBtn, avatarBtn])
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-20.adjustedW)
            $0.centerX.equalToSuperview()
        }
        
        upperLine.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.adjustedW)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(15.adjustedW)
        }
        
        clothBtn.snp.makeConstraints{
            $0.top.equalTo(upperLine.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(270.adjustedW)
        }
        
        middleLine.snp.makeConstraints{
            $0.top.equalTo(clothBtn.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(15.adjustedW)
        }
        
        avatarBtn.snp.makeConstraints{
            $0.top.equalTo(middleLine.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(270.adjustedW)
        }
        
        lowerLine.snp.makeConstraints{
            $0.top.equalTo(avatarBtn.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(15.adjustedW)
        }
    }
}
