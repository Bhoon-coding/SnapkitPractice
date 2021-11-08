//
//  HomeViewController.swift
//  Pods
//
//  Created by BH on 2021/10/07.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    lazy var coverView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var imageView = UIImageView()
    lazy var logoImage = UIImage(named: "Logo")
    lazy var logoButton: UIButton = {
        let btn = UIButton(type: .system) // system을 하면 버튼 클릭효과
        btn.setTitle("Button", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 0.5401045084, blue: 0.2833312452, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.backgroundColor = .darkGray
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    var logoViewLeadingConstraint: Constraint? = nil // ? 공부해보기
    
    // BlockView에 버튼 추가
    lazy var blockView: UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    lazy var blockViewButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("bring LogoView", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.backgroundColor = .cyan
        btn.layer.cornerRadius = 16
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogoUI()
        
    }
    
    func setLogoUI() {
        // Logo 뷰
        
        self.view.addSubview(blockView)
        self.blockView.addSubview(blockViewButton)
        self.view.addSubview(coverView)
        self.coverView.addSubview(imageView)
        self.coverView.addSubview(logoButton)
    
        blockView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        blockViewButton.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(50)
            $0.bottom.equalTo(blockView.snp.bottom).inset(20)
            $0.centerX.equalTo(blockView)
            blockViewButton.addTarget(self, action: #selector(hideBlockView), for: .touchUpInside)
        }
        
        coverView.snp.makeConstraints {
            $0.edges.equalTo(blockView.snp.edges)
            self.logoViewLeadingConstraint = $0.left.equalToSuperview().offset(0).constraint
//            self.logoViewLeadingConstraint = $0.left.equalTo(self.blueView.snp.left).inset(0).constraint // << .constraint로 현재 constarint를 가져온다.
        }
        
        imageView.image = logoImage
        imageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 67, height: 78))
            $0.center.equalTo(coverView.snp.center)
        }
        
        logoButton.snp.makeConstraints {
            $0.bottom.equalTo(coverView.snp.bottom)
            $0.centerX.equalTo(coverView)
            $0.size.equalTo(CGSize(width: 200, height: 50))
//            logoButton.addTarget(self, action: #selector(moveLogoView), for: .touchUpInside)
            logoButton.addTarget(self, action: #selector(hideLogoView), for: .touchUpInside)
        }
        
    }
    
    // LogoView 하단 버튼 클릭시 오른쪽으로 이동
//    var Offset = 0
//
//    @objc fileprivate func hideLogoView() {
//        print("offset is ===> ", Offset)
//        Offset += 70
//        self.logoViewLeadingConstraint?.update(offset: Offset)
//
//    }
    
    // LogoView의 모든 요소들을 숨김 (로고뷰, 로고 이미지, 버튼)
        @objc fileprivate func hideLogoView() {
            self.coverView.isHidden = true
            self.blockView.isHidden = false
        }
    
    @objc fileprivate func hideBlockView() {
        self.blockView.isHidden = true
        self.coverView.isHidden = false
    }
}


// 전처리
#if DEBUG

import SwiftUI
@available(iOS 13.0, *)
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    // update
    func updateUIViewController(_ uiViewController: UIViewController , context: Context) {

    }
    // makeui
    func makeUIViewController(context: Context) -> UIViewController {
        HomeViewController()
    }
}

struct ViewController_Previews: PreviewProvider {

    @available(iOS 13.0, *)
    static var previews: some View {
        // UIViewControllerRepresentable에 지정된 이름.
        
            ViewControllerRepresentable()
                .previewDevice("iPhone 12")
        }

            
    }

#endif

