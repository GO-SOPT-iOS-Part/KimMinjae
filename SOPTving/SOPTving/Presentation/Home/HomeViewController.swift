//
//  HomeCollectionViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/28.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func updateScrollViewOffset(y: CGFloat)
}


final class HomeViewController: BaseViewController {

    // MARK: - Properties

    private var viewModel: HomeViewModel

    private var posterCarouselImages = Poster.dummy()

    private var movies: [Movie] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    weak var delegate: HomeViewControllerProtocol?

    // MARK: - UI Components

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .tvingBlack
    }

    @frozen
    enum Section: Int, CaseIterable {
        case carousel = 0
        case liveChannel
        case movieAndDrama
        case imageBanner
        case paramountNew
        case favoriteMovies
        case programCollection
        case animations

        var sectionInsetBottom: CGFloat {
            switch self {
            case .liveChannel:
                return 18
            case .movieAndDrama, .paramountNew, .favoriteMovies, .programCollection, .animations:
                return 49
            case .imageBanner:
                return 38
            case .carousel:
                return 38
            }
        }

        var headerText: String {
            switch self {
            case .liveChannel:
                return Headers.popularLiveChannel
            case .movieAndDrama, .paramountNew, .favoriteMovies, .programCollection, .animations:
                return Headers.mustsee
            case .imageBanner, .carousel:
                return Headers.empty
            }
        }
    }

    // MARK: - View Life Cycle

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        makeArrayForCarouselView()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    private func setDelegate() {
        collectionView.dataSource = self
    }

    override func setStyle() {
        view.backgroundColor = .tvingBlack
        collectionView.do {
            $0.register(cell: MovieDramaCollectionViewCell.self)
            $0.register(cell: PopularChannelCollectionViewCell.self)
            $0.register(cell: ImageBannerCollectionViewCell.self)
            $0.registerHeaderView(reusableView: MainSectionHeaderView.self)
            $0.register(cell: ContainerCarouselCollectionViewCell.self)
            $0.delegate = self
        }
    }

    override func setLayout() {
        view.addSubviews(
            collectionView
        )

        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewController {
    func makeArrayForCarouselView() {
        self.posterCarouselImages.insertElementsBackAndForward()
    }

    private func bind() {
        viewModel.moviesFetched = { movies in
            if let movies {
                self.movies = movies
            }

        }
    }
}

// MARK: - UI & Layout

private extension HomeViewController {

    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in

            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }

            switch sectionType {
            case .movieAndDrama, .paramountNew, .favoriteMovies, .programCollection, .animations:
                return self.createMovieAndDramaSectionLayout(sectionType: sectionType)
            case .liveChannel:
                return self.createLiveChannelSectionLayout(sectionType: sectionType)
            case .imageBanner:
                return self.createImageBannerSectionLayout(sectionType: sectionType)
            case .carousel:
                return self.createCarouselSectionLayout(sectionType: sectionType)
            }
        }

        return layout
    }

    func createMovieAndDramaSectionLayout(sectionType: Section) -> NSCollectionLayoutSection {
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
        section.contentInsets = .init(top: 0, leading: 15, bottom: sectionType.sectionInsetBottom, trailing: 7)

        return section
    }

    func createLiveChannelSectionLayout(sectionType: Section) -> NSCollectionLayoutSection {
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
        section.contentInsets = .init(top: 0, leading: 12, bottom: sectionType.sectionInsetBottom, trailing: 5)

        return section
    }

    func createImageBannerSectionLayout(sectionType: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let gropSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(58)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: gropSize, repeatingSubitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: sectionType.sectionInsetBottom, trailing: 0)

        return section
    }

    func createCarouselSectionLayout(sectionType: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: sectionType.sectionInsetBottom, trailing: 0)

        return section
    }

    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
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

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.updateScrollViewOffset(y: scrollView.contentOffset.y)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }

        let header = collectionView.dequeueHeaderView(type: MainSectionHeaderView.self, forIndexPath: indexPath)

        guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionReusableView() }
        header.configHeaderView(text: sectionType.headerText)
        return header
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = Section(rawValue: section) else { return 0 }
        if sectionType == .imageBanner || sectionType == .carousel {
            return 1
        }
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = Section(rawValue: indexPath.section) else {
            print("Wrong Section !")
            return UICollectionViewCell()
        }

        switch sectionType {
        case .carousel:
            let cell = collectionView.dequeueReusableCell(type: ContainerCarouselCollectionViewCell.self, forIndexPath: indexPath)
            cell.initCell(posters: posterCarouselImages)
            return cell
        case .imageBanner:
            let cell = collectionView.dequeueReusableCell(type: ImageBannerCollectionViewCell.self, forIndexPath: indexPath)
            return cell
        case .liveChannel:
            let cell = collectionView.dequeueReusableCell(type: PopularChannelCollectionViewCell.self, forIndexPath: indexPath)
            cell.configureCell(rank: indexPath.item + 1, channel: movies[indexPath.item])
            return cell
        case .movieAndDrama, .paramountNew, .programCollection, .favoriteMovies, .animations:
            let cell = collectionView.dequeueReusableCell(type: MovieDramaCollectionViewCell.self, forIndexPath: indexPath)
            cell.configureCell(movie: movies[indexPath.item])
            return cell
        }
    }
}
