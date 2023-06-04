//
//  MakeClothVC.swift
//  CloseFit
//
//  Created by saint on 2023/05/25.
//

import UIKit
import SnapKit
import Then

class MakeClothVC: UIViewController {
    
    private let clothVideo = ClothVideo()
    
    private let closeBtn = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "closeBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then{
        $0.text = "의류등록"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20.adjustedW, weight: .medium)
    }
    
    private let detailLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.textColor = .black
        let boldFont = UIFont.systemFont(ofSize: 24.adjustedW, weight: .medium)
        let lightFont = UIFont.systemFont(ofSize: 24.adjustedW, weight: .light)
        
        let boldString = NSAttributedString(string: "정확한 측정", attributes: [
            .font: boldFont])
        let normalString = NSAttributedString(string: "을 위해\n의류 사이즈를 입력해 주세요.", attributes: [
            .font: lightFont])
        let title = boldString + normalString
        $0.attributedText = title
    }
    
    private let subLabel = UILabel().then{
        $0.numberOfLines = 2
        $0.text = "보다 정확한 측정을 위해\n정확한 정보를 입력해주시기 바랍니다."
        $0.font = .systemFont(ofSize: 14.adjustedW, weight: .light)
        $0.textColor = .systemGray2
    }
    
    private let clothBtn1 = UIButton().then {
        $0.backgroundColor = .systemGray
        //        $0.layer.cornerRadius = 25
        //        $0.layer.borderWidth = 1.0
        //        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .medium)
        $0.setTitle("상의", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let clothBtn2 = UIButton().then {
        $0.backgroundColor = .systemGray
        //        $0.layer.cornerRadius = 25
        //        $0.layer.borderWidth = 1.0
        //        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .medium)
        $0.setTitle("하의", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let sizeBtn1 = UIButton().then {
        $0.backgroundColor = .systemGray
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .medium)
        $0.setTitle("XS", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let sizeBtn2 = UIButton().then {
        $0.backgroundColor = .systemGray
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .medium)
        $0.setTitle("S", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let sizeBtn3 = UIButton().then {
        $0.backgroundColor = .systemGray
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .medium)
        $0.setTitle("M", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let sizeBtn4 = UIButton().then {
        $0.backgroundColor = .systemGray
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .medium)
        $0.setTitle("L", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let sizeBtn5 = UIButton().then {
        $0.backgroundColor = .systemGray
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .medium)
        $0.setTitle("XL", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let sizeBtn6 = UIButton().then {
        $0.backgroundColor = .systemGray
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .medium)
        $0.setTitle("FREE", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    private let checkBox = UIImageView().then{
        $0.image = UIImage(named: "checkbox")
        $0.backgroundColor = .clear
    }
    
    private let checkLabel = UILabel().then{
        $0.text = "측정 튜토리얼 함께 보기"
        $0.font = .systemFont(ofSize: 20.adjustedW, weight: .light)
        $0.textColor = .black
    }
    
    private let measureBtn = UIButton().then {
        $0.backgroundColor = .black
        $0.titleLabel?.font = .systemFont(ofSize: 24.adjustedW, weight: .light)
        $0.setTitle("측정 시작하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        pressBtn()
    }
    
    private func pressBtn(){
        closeBtn.press { [self] in
            self.dismiss(animated: true)
        }
        
        let optionBtns = [clothBtn1, clothBtn2, sizeBtn1, sizeBtn2, sizeBtn3, sizeBtn4, sizeBtn5, sizeBtn6]
        
        for button in optionBtns {
            button.press {
                if button.backgroundColor == .black {
                    button.backgroundColor = .systemGray
                } else {
                    button.backgroundColor = .black
                }
            }
        }
        measureBtn.press { [weak self] in
            self?.clothVideo.onCompletion = {
                self?.dismiss(animated: true)
            }
            self?.clothVideo.modalPresentationStyle = .overFullScreen
            self?.present(self!.clothVideo, animated: true, completion: nil)
        }
    }
}

extension MakeClothVC{
    private func setLayout(){
        view.backgroundColor = .white
        view.addSubviews([closeBtn, titleLabel, detailLabel, subLabel, clothBtn1, clothBtn2])
        view.addSubviews([sizeBtn1, sizeBtn2, sizeBtn3, sizeBtn4, sizeBtn5, sizeBtn6])
        view.addSubviews([checkBox, checkLabel, measureBtn])
        
        closeBtn.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.height.width.equalTo(24.adjustedW)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20.adjustedW)
            $0.centerX.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(50.adjustedW)
            $0.leading.equalToSuperview().offset(20)
        }
        
        subLabel.snp.makeConstraints{
            $0.top.equalTo(detailLabel.snp.bottom).offset(16.adjustedW)
            $0.leading.equalToSuperview().offset(20)
        }
        
        clothBtn1.snp.makeConstraints{
            $0.top.equalTo(subLabel.snp.bottom).offset(80.adjustedW)
            $0.leading.equalToSuperview().offset(80)
            $0.width.equalTo(100.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        clothBtn2.snp.makeConstraints{
            $0.top.equalTo(subLabel.snp.bottom).offset(80.adjustedW)
            $0.trailing.equalToSuperview().offset(-80)
            $0.width.equalTo(100.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        sizeBtn1.snp.makeConstraints{
            $0.top.equalTo(clothBtn1.snp.bottom).offset(80.adjustedW)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(100.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        sizeBtn2.snp.makeConstraints{
            $0.top.equalTo(sizeBtn1.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        sizeBtn3.snp.makeConstraints{
            $0.top.equalTo(sizeBtn1.snp.top)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(100.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        sizeBtn4.snp.makeConstraints{
            $0.top.equalTo(sizeBtn1.snp.bottom).offset(20.adjustedW)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(100.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        sizeBtn5.snp.makeConstraints{
            $0.top.equalTo(sizeBtn4.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        sizeBtn6.snp.makeConstraints{
            $0.top.equalTo(sizeBtn4.snp.top)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(100.adjustedW)
            $0.height.equalTo(40.adjustedW)
        }
        
        checkBox.snp.makeConstraints{
            $0.centerY.equalTo(checkLabel)
            $0.leading.equalTo(checkLabel.snp.trailing).offset(12)
            $0.width.height.equalTo(28)
        }
        
        checkLabel.snp.makeConstraints{
            $0.top.equalTo(sizeBtn4.snp.bottom).offset(80.adjustedW)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(80)
        }
        
        measureBtn.snp.makeConstraints{
            $0.top.equalTo(checkBox.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(56)
        }
        
    }
}
