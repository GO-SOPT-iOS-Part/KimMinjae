//
//  WelcomeViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/14.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - UI Components

    private let tvingImageView = UIImageView(
        image: ImageLiterals.Auth.tvingLogo
    )

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .font(.pretendardBold, ofSize: 23)
        label.textColor = .tvingWhite
        label.textAlignment = .center
        return label
    }()

    private lazy var backToMainButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .tvingRed
        config.baseForegroundColor = .tvingWhite
        var titleAddr = AttributedString("메인으로")
        titleAddr.font = .font(.pretendardSemiBold, ofSize: 14)
        config.attributedTitle = titleAddr

        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 3
        let action = UIAction { _ in
            self.navigationController?
                .popToRootViewController(animated: false)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar()
        style()
        setLayout()
    }
}

// MARK: - UI & Layout

private extension WelcomeViewController {
    func setNavigationbar() {
        self.navigationController?.navigationBar.isHidden = true
    }

    func style() {
        view.backgroundColor = .tvingBlack
    }

    func setLayout() {
        view.addSubviews(
            tvingImageView,
            welcomeLabel,
            backToMainButton
        )

        tvingImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tvingImageView.snp.bottom).offset(67)
        }

        backToMainButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(66)
            make.height.equalTo(52)
        }
    }
}

// MARK: - Methods

extension WelcomeViewController {
    func dataBind(nameOrEmail: String) {
        welcomeLabel.text = "\(nameOrEmail)님\n반가워요!"
    }
}
