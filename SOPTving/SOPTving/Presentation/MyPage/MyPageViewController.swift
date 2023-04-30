//
//  MyPageViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/24.
//

import UIKit

import SnapKit
import Then

final class MyPageViewController: BaseViewController {

    // MARK: - Properties

    private let viewModel: MyPageViewModel

    // MARK: - UI Components
    private lazy var navigationBarView = NavigationBarView(self, type: .myPage)
    private let tableView = UITableView()

    // MARK: - View Life Cycle

    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLayoutSubviews() {
        setHeaderFooterView()
    }

    // MARK: - UI & Layout

    override func setStyle() {
        tableView.do {
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 55
            $0.backgroundColor = .tvingBlack
            $0.separatorStyle = .none
            $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.className)
            $0.register(SectionSeperatorView.self, forHeaderFooterViewReuseIdentifier: SectionSeperatorView.className)
            $0.delegate = self
            $0.dataSource = self
        }
    }

    override func setLayout() {
        view.addSubviews(
            navigationBarView,
            tableView
        )

        navigationBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Methods
extension MyPageViewController {
    private func setHeaderFooterView() {
        tableView.tableHeaderView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 350))
        tableView.tableFooterView = LogoutFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
    }
}

// MARK: - UITableViewDelegate

extension MyPageViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.myPageList.count
    }
}

// MARK: - UITableViewDataSource

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myPageList[section].count
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return section == 0
        ? tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionSeperatorView.className)
        : nil
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }
}
