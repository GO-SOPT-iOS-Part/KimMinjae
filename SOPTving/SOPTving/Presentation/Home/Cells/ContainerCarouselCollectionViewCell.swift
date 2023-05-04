//
//  ContainerCarouselCollectionViewCell.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/03.
//

import UIKit

final class ContainerCarouselCollectionViewCell: UICollectionViewCell {

    private var posters: [Poster] = []
    private var timer: Timer?

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
        collectionView.contentInsetAdjustmentBehavior = .never
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
        pageControl.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return pageControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setLayout()
        setDelegate()
        activateTimer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setStyle() {
        self.backgroundColor = .tvingBlack
    }

    private func setLayout() {
        contentView.addSubviews(carouselCollectionView, pageControl)

        carouselCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        pageControl.snp.makeConstraints { make in
            make.top.equalTo(carouselCollectionView.snp.bottom)
            make.leading.equalToSuperview().offset(-20)
        }
    }
    
}

extension ContainerCarouselCollectionViewCell {
    private func setDelegate() {
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
    }

    private func invalidateTimer() {
        timer?.invalidate()
    }

    private func activateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
    }

    @objc
    private func timerCallBack() {
        let visibleItem = carouselCollectionView.indexPathsForVisibleItems[0].item
        let nextItem = visibleItem + 1
        let initialPosterCounts = posters.count - 2

        carouselCollectionView.scrollToItem(at: IndexPath(item: nextItem, section: 0), at: .centeredHorizontally, animated: true)


        if visibleItem == initialPosterCounts {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.carouselCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
        pageControl.currentPage = visibleItem % initialPosterCounts
    }

    func initCell(posters: [Poster]) {
        self.posters = posters
    }

    func setFirstPosition() {
        carouselCollectionView.setContentOffset(
            .init(x: Size.screenWidth, y: carouselCollectionView.contentOffset.y), animated: false)
    }
}

extension ContainerCarouselCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        setFirstPosition()
        return CGSize(width: Size.screenWidth, height: floor(ScreenUtils.getHeight(500)))
    }
}

extension ContainerCarouselCollectionViewCell: UICollectionViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        invalidateTimer()
        activateTimer()
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

extension ContainerCarouselCollectionViewCell: UICollectionViewDataSource {
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
