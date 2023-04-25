//
//  LogoutTableViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/25.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    private let logoutButton = TvingButton(type: .logout)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
