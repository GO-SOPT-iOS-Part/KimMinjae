//
//  LogoutFooterView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/25.
//

import UIKit

final class LogoutFooterView: UITableViewHeaderFooterView {

    private let logoutButton = TvingButton(type: .logout)

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setStyle() {
        contentView.backgroundColor = .tvingBlack
    }


    private func setLayout() {
        contentView.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(23)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(55)
        }
    }
}
