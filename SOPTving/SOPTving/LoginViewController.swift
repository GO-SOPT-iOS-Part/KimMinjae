//
//  LoginViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/13.
//

import UIKit

final class LoginViewController: UIViewController {

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.font = .font(.pretendardRegular, ofSize: 23)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tvingBlack
        self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(
            image: ImageLiterals.Auth
                .buttonBefore
                .withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )

        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc
    private func backTapped() {
        navigationController?.popViewController(animated: false)
    }
}
