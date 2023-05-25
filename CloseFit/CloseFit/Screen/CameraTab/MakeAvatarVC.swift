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
    
    private let closeBtn = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "closeBtn"), for: .normal)
        $0.contentMode = .scaleAspectFit
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
    }
}

extension MakeAvatarVC{
    private func setLayout(){
        view.backgroundColor = .systemPurple
        view.addSubviews([closeBtn])
        
        closeBtn.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.height.width.equalTo(24.adjustedW)
        }
    }
}

