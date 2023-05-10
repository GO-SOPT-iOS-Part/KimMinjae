//
//  UICollectionView+.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/05.
//

import UIKit


extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.className,
                                                  for: indexPath) as? T else {
            fatalError("deque Collectionview cell failed \(T.className)")
        }
        return cell
    }

    func dequeueHeaderView<T: UICollectionReusableView>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.className,
            for: indexPath
        ) as? T else {
            fatalError("deque Collectionview Header View failed: \(T.className)")
        }
        return view
    }

    func dequeueFooterView<T: UICollectionReusableView>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.className,
            for: indexPath
        ) as? T else {
            fatalError("deque Collectionview Footer View failed: \(T.className)")
        }
        return view
    }

    func register<T: UICollectionViewCell>(cell: T.Type,
                                           forCellWithReuseIdentifier reuseIdentifier: String = T.className) {
        register(cell, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func registerHeaderView<T: UICollectionReusableView>(reusableView: T.Type,
                                           forCellWithReuseIdentifier reuseIdentifier: String = T.className) {
        register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
    }

    func registerFooterView<T: UICollectionReusableView>(reusableView: T.Type,
                                           forCellWithReuseIdentifier reuseIdentifier: String = T.className) {
        register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifier)
    }
}
