//
//  BaseView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/24.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setStyle() {}

    /// Hierarchy, Constraints (계층 및 제약조건) 설정 메서드
    func setLayout() {

    }

}
