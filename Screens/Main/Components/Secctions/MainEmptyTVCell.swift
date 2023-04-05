//
//  MainEmptyTVCell.swift
//  Qrooto
//
//  Created by Evgeny on 28.12.2022.
//  Copyright © 2022 House of Apps. All rights reserved.
//

import UIKit

class MainEmptyTVCell: UITableViewCell {
    @IBOutlet private var emptyTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        emptyTitle.text = R.string.localizable.mainSearchBarEmptyResult()
    }
}
