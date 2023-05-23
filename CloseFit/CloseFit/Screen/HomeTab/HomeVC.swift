//
//  HomeVC.swift
//  CloseFit
//
//  Created by saint on 2023/05/18.
//

import UIKit
import SnapKit
import Then

class HomeVC: UIViewController {
    
    private let homeUpperView = UIImageView().then{
        $0.image = UIImage(named: "home1")
        $0.backgroundColor = .clear
    }
    
    private let homeLowerView = UIImageView().then{
        $0.image = UIImage(named: "home2")
        $0.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setLayout()
    }
}

extension HomeVC{
    private func setLayout(){
        self.view.addSubviews([homeUpperView, homeLowerView])
        
        homeUpperView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(450.adjustedW)
        }
        
        homeLowerView.snp.makeConstraints{
            $0.top.equalTo(homeUpperView.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(220.adjustedW)
        }
        
        
    }
}
