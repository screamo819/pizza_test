//
//  .swift
//  Qrooto
//
//  Created by Andrey Shemet on 18.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView
import RxSwift
import RxCocoa

final class MainFiltersView: UIStackView {
	private var items: [MainHeaderFilterType] = []
	
	@IBOutlet private var collectionView: UICollectionView!
	
    fileprivate let didTapItem = PublishSubject<Int>()
    
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.collectionView.register(R.nib.mainFilterTextCVCell)
		self.collectionView.register(R.nib.mainFilterIconCVCell)
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
	}
	
	func localizeStrings() {
		collectionView.reloadData()
	}
	
	func setup(_ items: [MainHeaderFilterType]?) {
		if let items = items {
			self.items = items
			collectionView.reloadData()
			hideSkeleton()
		} else {
			showAnimatedSkeleton()
		}
	}
	
	func showAnimatedSkeleton() {
		collectionView.showAnimatedGradientSkeleton(transition: .none)
	}
	
	func hideAnimations() {
		collectionView.hideSkeleton()
	}
}

extension Reactive where Base == MainFiltersView {
    var didTapFilterItem: Observable<Int> {
        base.didTapItem.asObservable()
    }
}

extension MainFiltersView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch items[indexPath.row] {
		case .icon(let model):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mainFilterIconCVCell, for: indexPath)!
			cell.setup(model)
			return cell
		case .text(let model):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mainFilterTextCVCell, for: indexPath)!
			cell.setup(model)
			return cell
		}
	}
}

extension MainFiltersView: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapItem.onNext(indexPath.row)
	}
}

// MARK: - SkeletonCollectionViewDelegate
extension MainFiltersView: SkeletonCollectionViewDelegate {
	func numSections(in collectionSkeletonView: UICollectionView) -> Int {
		1
	}
	
	func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		8
	}
	
	func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
		return "MainFilterTextCVCell"
	}
}
