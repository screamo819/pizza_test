//
//  MainHeaderView.swift
//  Qrooto
//
//  Created by Andrey Shemet on 18.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MainHeaderView: UIView {
	@IBOutlet fileprivate var filtersView: MainFiltersView!
    @IBOutlet fileprivate var categoryView: MainCategoryView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func localizeStrings() {
		filtersView.localizeStrings()
        categoryView.localizeStrings()
	}
	
	func setup(_ model: MainHeaderModel?) {
        
		filtersView.setup(model?.filters)
		if let filters = model?.filters {
			filtersView.isHidden = filters.isEmpty
		} else {
			filtersView.isHidden = true
		}
        
        categoryView.setup(items: model?.category)
        if let category = model?.category {
            categoryView.isHidden = category.isEmpty
        } else {
            categoryView.isHidden = false
        }
	}
}

extension Reactive where Base == MainHeaderView {
    var filterSelected: Observable<Int> {
        base.filtersView.rx.didTapFilterItem
    }
    var categorySelected: Observable<Int> {
        base.categoryView.rx.didTapCategoryItem
    }
}
