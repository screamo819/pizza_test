//
//  MainFilterCVCell.swift
//  Qrooto
//
//  Created by Andrey Shemet on 18.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit

class MainFilterTextCVCell: UICollectionViewCell {
	@IBOutlet private var titleLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		self.layer.cornerRadius = 19
		self.layer.masksToBounds = true
	}
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }
	
	func setup(_ model: MainHeaderFilterTextModel) {
		titleLabel.text = model.title
		backgroundColor = model.color
	}
}
