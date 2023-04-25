//
//  MyPageViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/24.
//

import UIKit

import SnapKit
import Then

@frozen
enum MyPageSection: Int {
    case profile = 0
    case personalInfo
    case tvingInfo

    var numberOfRows: Int {
        switch self {
        case .profile:
            return 1
        case .personalInfo:
            return 5
        case .tvingInfo:
            return 4
        }
    }

    var footerView: UIView? {
        switch self {
        case .profile:
            return nil
        case .personalInfo:
            return SectionSeperatorView()
        case .tvingInfo:
            return LogoutFooterView()
        }
    }

    var estimatedRowHeight: CGFloat {
        switch self {
        case .profile:
            return 400
        case .personalInfo, .tvingInfo:
            return 300
        }
    }

    var estimatedFooterHeight: CGFloat {
        switch self {
        case .profile:
            return 0
        case .personalInfo:
            return 40
        case .tvingInfo:
            return 50
        }
    }
}


final class MyPageViewController: BaseViewController {

    // MARK: - Properties

    private let viewModel: MyPageViewModel

    // MARK: - UI Components

    private let tableView = UITableView()

    // MARK: - View Life Cycle

    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }


    // MARK: - UI & Layout

    override func setStyle() {
        tableView.do {
            $0.rowHeight = UITableView.automaticDimension
            $0.backgroundColor = .tvingBlack
            $0.separatorStyle = .none
            $0.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.className)
            $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.className)
            $0.register(SectionSeperatorView.self, forHeaderFooterViewReuseIdentifier: SectionSeperatorView.className)
            $0.register(LogoutFooterView.self, forHeaderFooterViewReuseIdentifier: LogoutFooterView.className)
            $0.delegate = self
            $0.dataSource = self
        }
    }

    override func setLayout() {
        view.addSubviews(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

//        footerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.height.equalTo(55)
//        }
//        footerView.layoutIfNeeded()
    }
}

// MARK: - UITableViewDelegate

extension MyPageViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return MyPageSection.tvingInfo.rawValue + 1
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = MyPageSection(rawValue: indexPath.section)
        else { return 0 }
        return section.estimatedRowHeight
    }
}

// MARK: - UITableViewDataSource

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: ProfileTableViewCell.className,
                    for: indexPath)
                    as? ProfileTableViewCell
            else { return UITableViewCell() }
            return cell
        case 1, 2:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: MyPageTableViewCell.className,
                    for: indexPath)
                    as? MyPageTableViewCell
            else { return UITableViewCell() }

            cell.configCell(
                title: viewModel.myPageList[indexPath.section][indexPath.item]
            )
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = MyPageSection(rawValue: section)
        else { return 0 }
        return section.numberOfRows
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionSeperatorView.className)
        case 2:
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: LogoutFooterView.className)
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        guard let section = MyPageSection(rawValue: section)
        else { return 0 }
        return section.estimatedFooterHeight
    }
}
