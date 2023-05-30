//
//  ClothCVC.swift
//  CloseFit
//
//  Created by saint on 2023/05/26.
//

import UIKit
import SnapKit
import Moya
import Then

class ClothCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let clothImage = UIImageView().then{
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 20
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .systemGray
    }
    
    private let priceLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        cellShape()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ClothCVC{
    
    // MARK: - Layout Helpers
    private func setLayout() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.addSubviews([clothImage, titleLabel, priceLabel])
        
        clothImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(176)
            $0.height.equalTo(200.adjustedW)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(clothImage.snp.bottom).offset(8.adjustedW)
            $0.leading.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.adjustedW)
            $0.leading.equalToSuperview()
        }
    }
    
    func cellShape() {
//        contentView.layer.borderColor = UIColor.brown2.cgColor
//        contentView.layer.borderWidth = 1
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 0.3
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
//        contentView.layer.masksToBounds = false
    }
    
    func dataBind(model: ClothModel) {
        clothImage.image = model.image
        titleLabel.text = model.title
        priceLabel.text = model.price
    }
}
