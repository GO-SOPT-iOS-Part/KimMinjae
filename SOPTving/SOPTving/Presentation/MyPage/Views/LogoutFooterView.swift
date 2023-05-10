//
//  LogoutFooterView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/25.
//

import UIKit

final class LogoutFooterView: BaseView {

    private let logoutButton = TvingButton(type: .logout)

    override func setStyle() {
        self.backgroundColor = .tvingBlack
    }

    override func setLayout() {
        self.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(23)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(55)
        }
    }
}
