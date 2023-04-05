//
//  MainBaseTVCell.swift
//  Qrooto
//
//  Created by Andrey Shemet on 09.03.2022.
//  Copyright © 2022 House of Apps. All rights reserved.
//

import UIKit

class MainBaseTVCell: UITableViewCell {
	func showAnimatedSkeleton() {
		super.showAnimatedSkeleton(transition: .none)
		self.isUserInteractionEnabled = false
	}
	
	func hideSkeleton() {
		super.hideSkeleton()
		self.isUserInteractionEnabled = true
	}
}
