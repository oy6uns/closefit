//
//  MakeAvatarVC.swift
//  CloseFit
//
//  Created by saint on 2023/05/25.
//

import UIKit
import SnapKit
import Then

class MakeAvatarVC: UIViewController {
    
    private let avatarVideo = AvatarVideo()
    
    private let closeBtn = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "closeBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then{
        $0.text = "아바타 생성"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20.adjustedW, weight: .medium)
    }
    
    private let detailLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.textColor = .black
        let boldFont = UIFont.systemFont(ofSize: 24.adjustedW, weight: .medium)
        let lightFont = UIFont.systemFont(ofSize: 24.adjustedW, weight: .light)
        
        let normalString1 = NSAttributedString(string: "정확한 측정을 위해\n", attributes: [
            .font: lightFont])
        let boldString1 = NSAttributedString(string: "키", attributes: [
            .font: boldFont])
        let normalString2 = NSAttributedString(string: "와 ", attributes: [
            .font: lightFont])
        let boldString2 = NSAttributedString(string: "몸무게", attributes: [
            .font: boldFont])
        let normalString3 = NSAttributedString(string: "를 입력해 주세요.", attributes: [
            .font: lightFont])
        let title = normalString1 + boldString1 + normalString2 + boldString2 + normalString3
        $0.attributedText = title
    }
    
    private let subLabel = UILabel().then{
        $0.numberOfLines = 2
        $0.text = "보다 정확한 측정을 위해\n정확한 정보를 입력해주시기 바랍니다."
        $0.font = .systemFont(ofSize: 14.adjustedW, weight: .light)
        $0.textColor = .systemGray2
    }
    
    let heightTextField = UITextField().then {
        $0.backgroundColor = .lightGray
        $0.textAlignment = .right
        $0.textColor = .black
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
        
        // 왼쪽 뷰에 '키' 라벨 추가
        let leftLabel = UILabel()
        leftLabel.text = "    키"
        leftLabel.textColor = .black
        leftLabel.isUserInteractionEnabled = false
        $0.leftView = leftLabel
        $0.leftViewMode = .always
        
        // 오른쪽 뷰에 'cm' 라벨과 패딩 추가
        let rightLabel = UILabel()
        rightLabel.text = "cm       "
        rightLabel.textColor = .black
        rightLabel.isUserInteractionEnabled = false
        
        let paddingView = UIView()
        paddingView.addSubview(rightLabel)
        paddingView.isUserInteractionEnabled = false
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLabel.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor),
            rightLabel.centerYAnchor.constraint(equalTo: paddingView.centerYAnchor)
        ])
        
        // paddingView의 너비를 rightLabel의 intrinsicContentSize와 동일하게 설정
        paddingView.widthAnchor.constraint(equalTo: rightLabel.widthAnchor, constant: 4).isActive = true
        
        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    let weightTextField = UITextField().then {
        $0.backgroundColor = .lightGray
        $0.textAlignment = .right
        $0.textColor = .black
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
        
        // 왼쪽 뷰에 '몸무게' 라벨 추가
        let leftLabel = UILabel()
        leftLabel.text = "    몸무게"
        leftLabel.textColor = .black
        leftLabel.isUserInteractionEnabled = false
        $0.leftView = leftLabel
        $0.leftViewMode = .always
        
        // 오른쪽 뷰에 'kg' 라벨과 패딩 추가
        let rightLabel = UILabel()
        rightLabel.text = "kg       "
        rightLabel.textColor = .black
        rightLabel.isUserInteractionEnabled = false
        
        let paddingView = UIView()
        paddingView.addSubview(rightLabel)
        paddingView.isUserInteractionEnabled = false
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLabel.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor),
            rightLabel.centerYAnchor.constraint(equalTo: paddingView.centerYAnchor)
        ])
        
        // paddingView의 너비를 rightLabel의 intrinsicContentSize와 동일하게 설정
        paddingView.widthAnchor.constraint(equalTo: rightLabel.widthAnchor, constant: 4).isActive = true
        
        $0.rightView = paddingView
        $0.rightViewMode = .always
    }
    
    private let subLabel2 = UILabel().then{
        $0.numberOfLines = 2
        $0.text = "*수정된 신장, 체중은 측정 후 계정 정보에\n자동 반영이 됩니다."
        $0.font = .systemFont(ofSize: 14.adjustedW, weight: .light)
        $0.textColor = .systemGray2
        $0.textAlignment = .center
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
        avatarVideo.onCompletion = { [weak self] in
            let madeAvatarVC = MadeAvatarVC()
            madeAvatarVC.modalPresentationStyle = .overFullScreen
            self?.present(madeAvatarVC, animated: true, completion: nil)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name("DismissModalView"),
            object: nil
        )
        // Add tap gesture recognizer to dismiss the keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Functions
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.async { [self] in
            dismiss(animated: true)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func pressBtn(){
        closeBtn.press { [self] in
            self.dismiss(animated: true)
        }
        
        measureBtn.press { [weak self] in
            self?.avatarVideo.modalPresentationStyle = .overFullScreen
            self?.present(self!.avatarVideo, animated: true, completion: nil)
        }
    }
}

extension MakeAvatarVC{
    private func setLayout(){
        view.backgroundColor = .white
        view.addSubviews([closeBtn, titleLabel, detailLabel, subLabel, heightTextField, weightTextField, subLabel2])
        
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
        
        heightTextField.snp.makeConstraints{
            $0.top.equalTo(subLabel.snp.bottom).offset(80.adjustedW)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(52)
        }
        
        weightTextField.snp.makeConstraints{
            $0.top.equalTo(heightTextField.snp.bottom).offset(40.adjustedW)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(52)
        }
        
        subLabel2.snp.makeConstraints{
            $0.top.equalTo(weightTextField.snp.bottom).offset(20.adjustedW)
            $0.centerX.equalToSuperview()
        }
        
        checkLabel.snp.makeConstraints{
            $0.top.equalTo(subLabel.snp.bottom).offset(380.adjustedW)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(80)
        }
        
        checkBox.snp.makeConstraints{
            $0.centerY.equalTo(checkLabel)
            $0.leading.equalTo(checkLabel.snp.trailing).offset(12)
            $0.width.height.equalTo(28)
        }
        
        measureBtn.snp.makeConstraints{
            $0.top.equalTo(checkBox.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(56)
        }
        
    }
}


