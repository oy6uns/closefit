//
//  CategoryVC3.swift
//  CloseFit
//
//  Created by saint on 2023/05/26.
//

import UIKit
import SnapKit
import Then

class CategoryVC3: UIViewController {
    
    private let categoryView = UIImageView().then{
        $0.image = UIImage(named: "brand")
        $0.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }
}

extension CategoryVC3{
    private func setLayout(){
        view.addSubviews([categoryView])
        
        categoryView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.height.equalTo(26)
        }
    }
}

