//
//  FilterTextCVCell.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit

class FilterTextCVCell: UICollectionViewCell {
    
    var backColor: UIColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
    var selectedColor: UIColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
    var defaultColor: UIColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
    
    @IBOutlet private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? backColor : UIColor.clear
            titleLabel.textColor = isSelected ? selectedColor : defaultColor
        }
    }
    
    func setup(_ model: FilterModel) {
        titleLabel.text = model.title
        titleLabel.textColor = defaultColor
    }
}

