//
//  TopTabBar.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

final class TopTabBar: BaseView {

    @frozen
    enum TabTitle: String, CaseIterable {
        case home = "홈"
        case live = "실시간"
        case tvProgram = "TV프로그램"
        case movie = "영화"
        case paramount = "파라마운트+"
        case kids = "키즈"
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .systemBackground
    }

    private let indicatorView = UIView()

    override func setStyle() {
        collectionView.do {
            $0.dataSource = self
            $0.register(TopTabBarCollectionViewCell.self, forCellWithReuseIdentifier: TopTabBarCollectionViewCell.className)
        }
    }

    override func setLayout() {
        self.addSubviews(collectionView, indicatorView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(<#T##amount: ConstraintOffsetTarget##ConstraintOffsetTarget#>)
        }
    }

}


extension TopTabBar {

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            return self.createSectionLayout()
        }
        return layout
    }

    private func createSectionLayout() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(15),
            heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup
            .horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}

extension TopTabBar: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TabTitle.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabBarCollectionViewCell.className, for: indexPath) as? TopTabBarCollectionViewCell
        else { return UICollectionViewCell() }

        let title = TabTitle.allCases[indexPath.item].rawValue
        cell.configureCell(title: title)
        return cell
    }
}
