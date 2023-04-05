//
//  SearchProductCell.swift
//  Qrooto
//
//  Created by Evgeny on 17.11.2022.
//  Copyright © 2022 House of Apps. All rights reserved.
//

import UIKit

class SearchProductCell: UITableViewCell {
    class var height: CGFloat { 59.5 }

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var separateViewLeftOffset: NSLayoutConstraint!
    @IBOutlet private var separateView: UIView!
    @IBOutlet private var actionDateToLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
    }
    
    func setup(_ product: SearchProduct, _ isLast: Bool) {
        separateViewLeftOffset.constant = isLast ? 0 : 16
        
        titleLabel.text = product.name
        titleLabel.numberOfLines = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        if let date = product.actionDateTo.toDate() {
            remainingTime(date: date, label: actionDateToLabel)
        } else {
            self.actionDateToLabel.text = ""
        }
    }
}
