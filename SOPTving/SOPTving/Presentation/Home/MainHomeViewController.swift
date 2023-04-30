//
//  MainHomeViewController.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/30.
//

import UIKit

final class MainHomeViewController: BaseViewController {
    // MARK: - Properties

    private let viewModel: MainHomeViewModel

    // MARK: - UI Components

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .tvingBlack
        $0.collectionViewLayout = layout
    }

    // MARK: - View Life Cycle

    init(viewModel: MainHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - UI & Layout

    override func setStyle() {
        collectionView.do {
            $0.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.className)
            $0.dataSource = self
            $0.delegate = self
        }
    }

    override func setLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MainHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }
}

// MARK: - UICollectionViewDataSource

extension MainHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.className, for: indexPath)
                as? HomeCollectionViewCell
        else { return UICollectionViewCell() }

        cell.initCellData(headerTexts: viewModel.headerText)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}
