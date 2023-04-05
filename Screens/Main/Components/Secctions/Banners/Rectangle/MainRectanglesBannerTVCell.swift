//
//  MainRectanglesBannerTVCell.swift
//  Qrooto
//
//  Created by Andrey Shemet on 19.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit
import SkeletonView

private let itemWidth: CGFloat = ((UIScreen.main.bounds.width - 32) / 3) * 2
private let cellSpacing: CGFloat = 16

class MainRectanglesBannerTVCell: MainBaseTVCell {
	private var items: [MainSmallRectangleCellModel] = [] {
		didSet {
			collectionView.reloadData()
		}
	}
	fileprivate var isLoading = false
	
	@IBOutlet private var collectionView: UICollectionView!
	var itemSelected: ((Int) -> Void)?
    var likeActionTap: ((Int) -> Void)?
    var unlikeActionTap: ((Int) -> Void)?
    var infoItemTap: ((Int) -> Void)?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		collectionView.register(R.nib.mainSmallRectangleBannerCVCell)
		
//		collectionView.delegate = self
//		collectionView.dataSource = self
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		items.removeAll()
	}
	
	func setup(_ items: [MainSmallRectangleCellModel]) {
		self.items = items
		self.hideSkeleton()
	}
	
	override func showAnimatedSkeleton() {
		self.isLoading = true
		self.isUserInteractionEnabled = false
		self.collectionView.reloadData()
	}

	override func hideSkeleton() {
		self.isLoading = false
		self.isUserInteractionEnabled = true
		self.collectionView.reloadData()
	}
}

extension MainRectanglesBannerTVCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mainSmallRectangleBannerCVCell, for: indexPath)!
		cell.setup(items[indexPath.row])
		if isLoading {
			cell.showAnimatedSkeleton(transition: .none)
		} else {
			cell.hideSkeleton()
		}
        cell.likeAction = { self.likeActionTap?(indexPath.row) }
        cell.unLikeAction = { self.unlikeActionTap?(indexPath.row) }
        cell.didTapInfo = { self.infoItemTap?(indexPath.row) }
		return cell
	}
}

extension MainRectanglesBannerTVCell: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		itemSelected?(indexPath.row)
	}
}

extension MainRectanglesBannerTVCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		.init(
			width: itemWidth,
			height: 138
		)
	}
}

extension MainRectanglesBannerTVCell: UIScrollViewDelegate {
	public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let pageWidth = itemWidth
		targetContentOffset.pointee = scrollView.contentOffset
		var factor: CGFloat = 0.5
		if velocity.x < 0 {
				factor = -factor
				print("right")
		} else {
				print("left")
		}

		let a: CGFloat = scrollView.contentOffset.x / pageWidth
		var index = Int( round(a + factor) )
		if index < 0 {
				index = 0
		}
		if index > items.count - 1 {
				index = items.count - 1
		}
		let indexPath = IndexPath(row: index, section: 0)

		if let cell = collectionView.cellForItem(at: indexPath) {
			collectionView.setContentOffset(.init(x: max(0, cell.frame.origin.x - 16), y: 0), animated: true)
		} else {
			collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
		}
	}
}

// MARK: - SkeletonCollectionViewDelegate
extension MainRectanglesBannerTVCell: SkeletonCollectionViewDelegate {
	func numSections(in collectionSkeletonView: UICollectionView) -> Int {
		1
	}
	
	func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		8
	}
	
	func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
		return "MainSmallRectangleBannerCVCell"
	}
}
