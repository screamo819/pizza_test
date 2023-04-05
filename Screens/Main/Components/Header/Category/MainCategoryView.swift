//
//  MainCategoryView.swift
//  Qrooto
//
//  Created by Evgeny on 06.02.2023.
//  Copyright © 2023 House of Apps. All rights reserved.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa

private let itemSize = CGSize(width: 70, height: 70)

final class MainCategoryView: UICollectionView {
    private var items: [MainCategoryModel] = []
    
    fileprivate let didTapItem = PublishSubject<Int>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.register(R.nib.mainCategoryCVCell)
        self.delegate = self
        self.dataSource = self
        self.isSkeletonable = true
    }
    
    func localizeStrings() {
        reloadData()
    }
    
    func setup(items: [MainCategoryModel]?) {
        if let items = items {
            self.items = items
            reloadData()
            self.hideAnimations()
        } else {
            showAnimatedSkeleton()
        }
    }
    
    func showAnimatedSkeleton() {
        super.showAnimatedGradientSkeleton(transition: .none)
    }
    
    func hideAnimations() {
        self.stopSkeletonAnimation()
        self.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}

extension Reactive where Base == MainCategoryView {
    var didTapCategoryItem: Observable<Int> {
        base.didTapItem.asObservable()
    }
}

extension MainCategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mainCategoryCVCell, for: indexPath)!
        cell.setup(items[indexPath.row])
        return cell
    }
}

extension MainCategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapItem.onNext(indexPath.row)
    }
}

//extension MainCategoryView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        itemSize
//    }
//}
//
//extension MainCategoryView: UIScrollViewDelegate {
//    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let pageWidth = itemSize.width
//        targetContentOffset.pointee = scrollView.contentOffset
//        var factor: CGFloat = 0.3
//        if velocity.x < 0 {
//                factor = -factor
//                print("right")
//        } else {
//                print("left")
//        }
//
//        let a: CGFloat = scrollView.contentOffset.x / pageWidth
//        var index = Int( round(a + factor) )
//        if index < 0 {
//                index = 0
//        }
//        if index > items.count - 1 {
//                index = items.count - 1
//        }
//        let indexPath = IndexPath(row: index, section: 0)
//
//        if let cell = cellForItem(at: indexPath) {
//            setContentOffset(.init(x: max(0, cell.frame.origin.x), y: 0), animated: true)
//        } else {
//            scrollToItem(at: indexPath, at: .left, animated: true)
//        }
//    }
//}

extension MainCategoryView: SkeletonCollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        "MainCategoryCVCell"
    }
}

extension MainCategoryView: SkeletonCollectionViewDelegate { }
