//
//  SectionSeperatorView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/25.
//

import UIKit

final class SectionSeperatorView: UITableViewHeaderFooterView {

    private let lineView = UIView().then {
        $0.backgroundColor = .tvingGray4
    }

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
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(17)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(1)
        }
    }
}
