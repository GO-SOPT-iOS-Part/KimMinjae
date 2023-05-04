//
//  NavigationBarView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/28.
//

import UIKit

protocol NavigationBarViewProtcol: AnyObject {
    func moveToMain()
    func moveToMyPage()
}

final class NavigationBarView: UIView {

    @frozen
    enum NavigationBarType {
        case tvingMain
        case myPage
        case onlyBackButton
    }

    private let type: NavigationBarType
    private let viewController: UIViewController
    weak var delegate: NavigationBarViewProtcol?

    private lazy var leftButton = UIButton().then {
        $0.adjustsImageWhenHighlighted = false
        $0.imageView?.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }

    private lazy var rightButton1 = UIButton().then {
        $0.adjustsImageWhenHighlighted = false
        $0.imageView?.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didTapRightButtonLeft), for: .touchUpInside)
    }

    private lazy var rightButton2 = UIButton().then {
        $0.adjustsImageWhenHighlighted = false
        $0.imageView?.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(didTapRightButtonRight), for: .touchUpInside)
    }

    init(_ viewController: UIViewController, type: NavigationBarType) {
        self.viewController = viewController
        self.type = type
        super.init(frame: .zero)
        setLayout()
        setLeftBarItem()
        setRightBarItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubviews(
            leftButton,
            rightButton1,
            rightButton2
        )

        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }

        rightButton2.snp.makeConstraints { make in
            make.centerY.equalTo(leftButton)
            make.trailing.equalToSuperview().inset(24)
        }

        rightButton1.snp.makeConstraints { make in
            make.centerY.equalTo(leftButton)
            make.trailing.equalTo(rightButton2.snp.leading).offset(-9)
        }
    }

    private func setLeftBarItem() {
        switch type {
        case .tvingMain:
            leftButton.setImage(ImageLiterals.Main.tvingWhiteLogo, for: .normal)
        case .myPage, .onlyBackButton:
            leftButton.setImage(ImageLiterals.Auth.buttonBefore, for: .normal)
        }
    }

    private func setRightBarItem() {
        switch type {
        case .tvingMain:
            rightButton1.isHidden = true
            rightButton2.setImage(ImageLiterals.MyPage.dusan, for: .normal)
        case .myPage:
            rightButton1.setImage(ImageLiterals.MyPage.alarm, for: .normal)
            rightButton2.setImage(ImageLiterals.MyPage.setting, for: .normal)
        case .onlyBackButton:
            return
        }
    }
}


private extension NavigationBarView {
    @objc
    func didTapBackButton() {
        if type == .tvingMain {
            delegate?.moveToMain()
        } else {
            viewController.navigationController?.popViewController(animated: true)
        }
    }

    @objc func didTapRightButtonLeft() {
        print("tapped")
    }

    @objc func didTapRightButtonRight() {
        if type == .tvingMain {
            delegate?.moveToMyPage()
        }
    }
}
