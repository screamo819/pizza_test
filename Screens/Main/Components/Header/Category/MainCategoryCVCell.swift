//
//  MainCategoryCVCell.swift
//  Qrooto
//
//  Created by Evgeny on 03.02.2023.
//  Copyright © 2023 House of Apps. All rights reserved.
//

import UIKit

class MainCategoryCVCell: UICollectionViewCell {
    
    @IBOutlet private var iconLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textAlignment = .center
        iconView.layer.cornerRadius = 10
        iconView.layer.shadowOpacity = 0.3
        iconView.layer.shadowRadius = 3
        iconView.layer.shadowOffset = CGSize(width: 0, height: 1)
        iconView.layer.shadowColor = UIColor.black.cgColor
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
    
    func setup(_ model: MainCategoryModel) {
        self.iconLabel.text = model.icon
        self.titleLabel.text = model.title
    }
}
