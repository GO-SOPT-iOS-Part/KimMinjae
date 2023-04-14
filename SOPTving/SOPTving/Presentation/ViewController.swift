//
//  ViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/13.
//

import UIKit

import SnapKit

final class ViewController: UIViewController {

    private lazy var button: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .tvingRed
        config.baseForegroundColor = .tvingWhite
        config.title = "시작하기"
        let button = UIButton(configuration: config)

        let action = UIAction { _ in
            let loginVC = ModuleFactory.shared.makeLoginViewController()
            self.navigationController?
                .pushViewController(loginVC, animated: false)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        

        view.backgroundColor = .tvingBlack

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

