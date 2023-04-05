//
//  TabBarItem.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit

final class TabBarItem: UIControl {
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var titleLabel: UILabel?
    
    var selectedColor: UIColor = UIColor(red: 0.253, green: 0.580, blue: 0.105, alpha: 1)
    var defaultColor: UIColor = UIColor(red: 0.592, green: 0.584, blue: 0.573, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            iconView.isHighlighted = isSelected
            iconView.tintColor = isSelected ? selectedColor : defaultColor
            titleLabel?.textColor = isSelected ? selectedColor : defaultColor
        }
    }
    
    func setup(_ item: TabBarItemModel) {
        self.titleLabel?.text = item.title
        self.iconView.image = item.image
        self.iconView.highlightedImage = item.highlightedImage
    }
}
