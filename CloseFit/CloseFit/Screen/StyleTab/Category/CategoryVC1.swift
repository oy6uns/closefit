//
//  CategoryVC1.swift
//  CloseFit
//
//  Created by saint on 2023/05/26.
//

import UIKit
import SnapKit
import Then

class CategoryVC1: UIViewController {
    
    static var clothList: [ClothModel] = [
        ClothModel(image:UIImage(named: "padding1")!, title: "AREA", price: "₩ 200,000"),
        ClothModel(image: UIImage(named: "shirts2")!, title: "AREA", price: "₩ 120,000"),
        ClothModel(image: UIImage(named: "shirts1")!, title: "AMI", price: "₩ 120,000"),
        ClothModel(image: UIImage(named: "pants1")!, title: "AMI", price: "₩ 169,000"),
        ClothModel(image: UIImage(named: "pants2")!, title: "AREA", price: "₩ 89,000")
    ]
    
    private let categoryView = UIImageView().then{
        $0.image = UIImage(named: "recommand")
        $0.backgroundColor = .clear
    }
    
    lazy var clothListCV : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.contentInset.bottom = 60
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    // MARK: - Constants
    final let imageListLineSpacing: CGFloat = 4.adjustedW

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        registerCVC()
    }
    
    private func registerCVC() {
        clothListCV.register(
            ClothCVC.self, forCellWithReuseIdentifier: ClothCVC.className)
    }
}

extension CategoryVC1{
    private func setLayout(){
        view.addSubviews([categoryView, clothListCV])
        
        categoryView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.height.equalTo(25)
        }
        
        clothListCV.snp.makeConstraints{
            $0.top.equalTo(categoryView.snp.bottom)
            $0.leading.equalToSuperview().offset(13.adjustedW)
            $0.trailing.equalToSuperview().offset(-13.adjustedW)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryVC1: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 176, height: 256.adjustedH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return imageListLineSpacing
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailBookVC = DetailViewController()
//        detailBookVC.bookdata = CameBookVC.bookList[indexPath.row]
//        detailBookVC.modalPresentationStyle = .overFullScreen
//        present(detailBookVC, animated: true, completion:nil)
//    }
}

// MARK: - UICollectionViewDataSource
extension CategoryVC1 : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryVC1.clothList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let clothCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothCVC.className, for: indexPath) as? ClothCVC else { return UICollectionViewCell() }
        clothCell.dataBind(model: CategoryVC1.clothList[indexPath.row])
        return clothCell
    }
}
