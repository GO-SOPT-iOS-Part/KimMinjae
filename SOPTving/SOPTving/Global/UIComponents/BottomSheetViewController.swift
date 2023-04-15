//
//  BottomSheetViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/15.
//

import UIKit

final class BottomSheetViewController: UIViewController {

    // MARK: - Properties
    typealias handler = ((String) -> Void)
    var completion: handler?

    // MARK: - UI Components

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 입력해주세요"
        label.textColor = .tvingBlack
        label.font = .font(.pretendardSemiBold, ofSize: 23)
        return label
    }()

    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .tvingGray2
        textField.font = .font(.pretendardMedium, ofSize: 14)
        textField.setLeftPadding(amount: 23)
        return textField
    }()

    private lazy var saveButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .tvingRed
        config.baseForegroundColor = .tvingWhite
        var titleAttr = AttributedString("저장하기")
        titleAttr.font = .font(.pretendardSemiBold, ofSize: 14)
        config.attributedTitle = titleAttr
        let button = UIButton(configuration: config)

        let action = UIAction { _ in
            guard let text = self.nicknameTextField.text
            else { return }
            self.completion?(text)
            self.hideBottomSheetWithAnimation()
        }
        button.addAction(action, for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setLayout()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first,
           touch.view == self.view {
            hideBottomSheetWithAnimation()
        }
    }
}

// MARK: - UI & Layout

private extension BottomSheetViewController {
    func style() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
    }

    func setLayout() {
        view.addSubview(containerView)
        containerView.addSubviews(
            titleLabel,
            nicknameTextField,
            saveButton
        )
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 2)

        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(20)
        }

        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(21)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }

        saveButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }

        containerView.layer.cornerRadius = 12
        containerView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner
        ]
    }
}

// MARK: - Show/Hide Animation
// MARK: - Methods

extension BottomSheetViewController {
    func showBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.8, delay: 0) {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.containerView.frame.height)
        }
    }

    func hideBottomSheetWithAnimation() {
        UIView.animate(withDuration: 0.8, delay: 0) {
            self.containerView.transform = .identity
            self.view.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

