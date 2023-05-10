//
//  TopTabBarView.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

protocol TopTabBarViewProtocol: AnyObject {
    func moveToTargetViewController(index: Int)
}

@frozen
enum TopTab: String, CaseIterable {
    case home = "홈"
    case live = "실시간"
    case tvProgram = "TV프로그램"
    case movie = "영화"
    case paramount = "파라마운트+"
    case kids = "키즈"

    var viewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController(viewModel: MainHomeViewModel())
        case .live:
            return LiveChannelViewController()
        case .tvProgram:
            return TVProgramViewController()
        case .movie:
            return MovieViewController()
        case .paramount:
            return ParamountViewController()
        case .kids:
            return KidsViewController()
        }
    }
}

final class TopTabBarView: BaseView {

    private var targetIndex: Int = 0 {
        didSet {
            moveIndicatorbar(targetIndex: targetIndex)
        }
    }

    weak var delegate: TopTabBarViewProtocol?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private let indicatorUnderLineView = UIView().then {
        $0.backgroundColor = .tvingGray4
    }
    private let indicatorView = UIView().then {
        $0.backgroundColor = .tvingWhite
    }

    override func setStyle() {
        collectionView.do {
            $0.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
            $0.delegate = self
            $0.dataSource = self
            $0.register(TopTabBarCollectionViewCell.self, forCellWithReuseIdentifier: TopTabBarCollectionViewCell.className)
        }
    }

    override func setLayout() {
        self.addSubviews(
            collectionView,
            indicatorUnderLineView,
            indicatorView
        )

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(indicatorUnderLineView.snp.top)
        }

        indicatorUnderLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }

        indicatorView.snp.makeConstraints { make in
            make.bottom.equalTo(indicatorUnderLineView.snp.top)
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(15)
            make.height.equalTo(3)
        }
    }
}

extension TopTabBarView {
    func moveIndicatorbar(targetIndex: Int) {
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        guard let cell = collectionView.cellForItem(at: indexPath) as? TopTabBarCollectionViewCell else { return }

        indicatorView.snp.remakeConstraints { make in
            make.centerX.equalTo(cell)
            make.width.equalTo(cell.getTitleFrameWidth())
            make.height.equalTo(3)
            make.bottom.equalTo(indicatorUnderLineView.snp.top)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    func setIndicatorBar(to targetIndex: Int) {
        self.targetIndex = targetIndex
    }

    func checkIsBarAndPageInSameIndex(for currentIndex: Int) -> Bool {
        return self.targetIndex == currentIndex
    }
}


extension TopTabBarView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = TopTab.allCases[indexPath.item].rawValue
        return title.getTextContentSize(withFont: .font(.pretendardRegular, ofSize: 17))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
}

extension TopTabBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetIndex = indexPath.item
        self.targetIndex = targetIndex
        delegate?.moveToTargetViewController(index: targetIndex)
    }
}

extension TopTabBarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TopTab.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabBarCollectionViewCell.className, for: indexPath) as? TopTabBarCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        let title = TopTab.allCases[indexPath.item].rawValue
        cell.configureCell(title: title)

        return cell
    }
}
