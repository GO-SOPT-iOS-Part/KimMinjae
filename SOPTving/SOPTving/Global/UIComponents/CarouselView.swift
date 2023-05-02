//
//  CarouselView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/03.
//

import UIKit

final class CarouselView: BaseView {

    private var posters: [Poster] = []

    private let carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentOffset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true // ?
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.className)
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.backgroundStyle = .minimal
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setDelegate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setStyle() {
        self.backgroundColor = .tvingBlack
    }

    override func setLayout() {
        self.addSubview(carouselCollectionView)
        self.addSubview(pageControl)
        carouselCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(ScreenUtils.getHeight(500))
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(carouselCollectionView.snp.bottom)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}

extension CarouselView {
    private func setDelegate() {
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
    }

    func initPosters(posters: [Poster]) {
        self.posters = posters
    }
}

extension CarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Size.screenWidth, height: ScreenUtils.getHeight(498))
    }
}

extension CarouselView: UICollectionViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //TODO: - Timer로 자동 이동

//        let count = images.count
//
//
//        // 4 1 2 3 4 1
        if scrollView.contentOffset.x == 0 { // 첫번째(4)가 보이면 4번째 index의 4로 이동시키기
            scrollView.setContentOffset(.init(x: Size.screenWidth * 4, y: scrollView.contentOffset.y), animated: false)
        }
        else if scrollView.contentOffset.x == Size.screenWidth * 5 { //마지막 1이 보이면 1번째 index의 1로 이동
            scrollView.setContentOffset(.init(x: Size.screenWidth, y: scrollView.contentOffset.y), animated: false)
        }
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX) - 1
    }
}

extension CarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.className, for: indexPath) as? CarouselCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureCarouselCell(poster: posters[indexPath.item])
        return cell
    }
}
