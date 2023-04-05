//
//  MainSectionHeaderView.swift
//  Qrooto
//
//  Created by Andrey Shemet on 19.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit

class MainSectionHeaderView: UIView {
    var didTapSectionHeaderButton: (() -> Void)?
    
	@IBOutlet private var titleLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    
    @IBAction func didTapMoreButton(_ sender: UIButton) {
        didTapSectionHeaderButton?()
    }
    
    override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
    func setup(_ model: MainSectionModel) {
        self.titleLabel.text = model.title// + " " + model.logo
	}
}
