//
//  HomeViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/28.
//

import UIKit

final class HomeViewController: BaseViewController {

    private let dummy = Content.dummy()
    private let channelDummy = Channel.dummy()

    private let viewModel: HomeViewModel

    @frozen
    enum Section: Int, CaseIterable {
        case movieAndDrama = 0
        case liveChannel
        case carousel
        case imageBanner
    }

    private lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: self.createLayout()
    ).then {
        $0.backgroundColor = .tvingBlack
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setStyle() {
        view.backgroundColor = .tvingBlack
        collectionView.do {
            $0.register(MovieDramaCollectionViewCell.self, forCellWithReuseIdentifier: MovieDramaCollectionViewCell.className)
            $0.register(PopularChannelCollectionViewCell.self, forCellWithReuseIdentifier: PopularChannelCollectionViewCell.className)
            $0.register(MainSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSectionHeaderView.className)
        }
    }

    override func setLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            print(sectionIndex)
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }

            if sectionType == .liveChannel {
                return self.createLiveChannelSectionLayout()
            } else if sectionType == .movieAndDrama {
                return self.createMovieAndDramaSectionLayout()

            }
            return nil
            //TODO: - layout
//            return section
        }

        return layout
    }
}


extension HomeViewController {

    private func createMovieAndDramaSectionLayout() -> NSCollectionLayoutSection {
        // item -> group -> section -> layout
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .estimated(150)
        )

        let group = NSCollectionLayoutGroup
            .horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let sectionHeader = createSectionHeader()

        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 7)

        return section
    }

    private func createLiveChannelSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 7)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .estimated(140)
        )
        let group = NSCollectionLayoutGroup
            .horizontal(layoutSize: groupSize, subitems: [item])


        let sectionHeader = createSectionHeader()
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 5)

        return section
    }

    private func createImageBannerSectionLayout() {

    }

    private func createCarouselSectionLayout() {

    }

    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(30)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        return sectionHeader
    }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }

        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSectionHeaderView.className, for: indexPath) as? MainSectionHeaderView else { return UICollectionReusableView() }
        header.configHeaderView(text: viewModel.headerText[indexPath.section])
        return header
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDramaCollectionViewCell.className, for: indexPath) as? MovieDramaCollectionViewCell else { return UICollectionViewCell() }

            cell.configureCell(content: dummy[indexPath.item])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularChannelCollectionViewCell.className, for: indexPath) as? PopularChannelCollectionViewCell else { return UICollectionViewCell() }

            cell.configureCell(rank: indexPath.item + 1, channel: channelDummy[indexPath.item])

            return cell
        default:
            return UICollectionViewCell()
        }

    }
}
