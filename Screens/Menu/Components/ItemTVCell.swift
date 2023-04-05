//
//  ItemTVCell.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit

class ItemTVCell: UITableViewCell {

    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        descriptionLabel.layer.cornerRadius = 10
        descriptionLabel.layer.masksToBounds = true
    }
    
    func setup(_ model: ItemModel) {
        self.titleLabel.text = model.title
        self.titleLabel.textColor = .black
        self.mainButton.titleLabel = "от \(model.id) руб."
        
        self.descriptionLabel.attributedText = model.description
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        
        if let url = model.pizzaBanner {
            self.pizzaImage.setImage(with: url, placeholder: "")
        }
    }
}

// MARK: - Actions
extension ItemTVCell {
    @objc private func touchUpInside() {
        mainButton.setTitleColor(selectedColor, for: .normal)
        mainButton.backgroundColor = .white
    }
    
    @objc private func touchDown() {
        mainButton.setTitleColor(.white, for: .normal)
        mainButton.backgroundColor = selectedColor
    }
}
