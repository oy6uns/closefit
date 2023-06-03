//
//  StyleVC.swift
//  CloseFit
//
//  Created by saint on 2023/05/18.
//

import UIKit
import SnapKit
import Then

class StyleVC: UIViewController {
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UnderlineSegmentedControl(items: ["추천", "신규", "브랜드", "상의", "하의"])
        segmentedControl.backgroundColor = .white
        segmentedControl.layer.cornerRadius = 0
        segmentedControl.layer.masksToBounds = true
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
  
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purple
        return view
    }()

    static var styleImage = UIImageView().then {
        $0.image = UIImage(named: "base")
        $0.contentMode = .scaleToFill
    }

    private let vc1 = CategoryVC1()
    private let vc2 = CategoryVC2()
    private let vc3 = CategoryVC3()
    private let vc4 = CategoryVC4()
    private let vc5 = CategoryVC5()

    private lazy var pageViewController: UIPageViewController = {
        // Page를 넘길 때 애니메이션 : scroll, 방향 : 수평
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        // 실제 페이지 변환은 아래의 currentPage에서 구현, 여기서는 pageVC 초기화만 해줌
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    // MARK: - dataVC : swipe시에 바뀔 뷰들을 저장해 놓은 ViewController 배열
    var dataViewControllers: [UIViewController] {
        [self.vc1, self.vc2, self.vc3, self.vc4, self.vc5]
    }
    
    // MARK: - currentPage : segmentedControl <-> pageViewController 동기화를 위한 변수
    var currentPage: Int = 0 {
        didSet {
            print(oldValue, self.currentPage) // 단순히, 커널창에서 페이지가 맞게 변환되고 있는지 확인해주기 위한 print문
            // 좌우로 스와이프 했을 때 그에 맞게 forward, reverse 애니메이션이 알맞게 나오게끔 direction 지정
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.pageViewController.setViewControllers([dataViewControllers[self.currentPage]], direction: direction, animated: true)
        }
    }
    
    override func viewDidLoad() {
        layout()
        setSegmentedControl()
        super.viewDidLoad()
    }
}

extension StyleVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - 이전 페이지로 이동(좌로 스와이프시)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index - 1 >= 0 // 만약, '(현재 viewcontroller의 index 번호) - 1' 이 0보다 크거나 같다면~
        else { return nil }
        return self.dataViewControllers[index - 1] // dataViewController 배열의 index 번호에서 1을 빼준다.
    }
    
    // MARK: - 다음 페이지로 이동(우로 스와이프시)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index + 1 < self.dataViewControllers.count // 만약, '(현재 viewcontroller의 index 번호) + 1' 이 0보다 작다면~
        else { return nil }
        return self.dataViewControllers[index + 1] // dataViewController 배열의 index 번호에서 1을 더해준다.
    }
    
    // MARK: - 애니메이션 종료시 Page Index와 SegmentedControl Index를 맞게 부여해주기 위한 함수
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?[0],
              let index = self.dataViewControllers.firstIndex(of: viewController)
        else { return }
        self.currentPage = index // currentPage 변수에 현재 페이지의 인덱스를 저장해줌
        self.segmentedControl.selectedSegmentIndex = index
        // 이 줄이 없으면, segmentedControl의 탭이 변경되지 않음
        // segmentedControl의 index 번호에 pageViewController의 index 번호를 저장해줌.
    }
}

extension StyleVC {
    
    // MARK: - Layout Helpers
    private func layout(){
        view.backgroundColor = .white
        self.view.addSubview(StyleVC.styleImage)
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.pageViewController.view)

        StyleVC.styleImage.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(380.adjustedW)
        }
        
        segmentedControl.snp.makeConstraints{
            $0.top.equalTo(StyleVC.styleImage.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }

        pageViewController.view.snp.makeConstraints{
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.bottom.equalToSuperview().offset(-85)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - segmentedControl 설정 함수
    private func setSegmentedControl(){
        
        // 현재 페이지 index 번호에 해당하는 segmentedcontrol이 아닐 때(for: .normal),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                      .font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        // 현재 페이지 index 번호에 해당하는 segmentedControl일 때(for: .selected),
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                                      .font: UIFont.systemFont(ofSize:16, weight: .semibold)], for: .selected)
        
        // 페이지가 변경되어 index값이 달라졌을 때,
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.changeValue(control: self.segmentedControl)
    }
    
    @objc private func changeValue(control: UISegmentedControl) {
        // currentPage 변수에 현재 선택된 Segmentcontrol의 index를 넣어줌 -> pageViewController와 index 번호 통일
        self.currentPage = control.selectedSegmentIndex
    }
}
