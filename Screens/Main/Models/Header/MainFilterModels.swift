//
//  MainFilterModels.swift
//  Qrooto
//
//  Created by Evgeny on 05.10.2022.
//  Copyright © 2022 House of Apps. All rights reserved.
//

import UIKit
import DomainModule

enum MainHeaderFilterType {
    case text(MainHeaderFilterTextModel)
    case icon(MainHeaderFilterIconModel)
}

struct MainHeaderFilterTextModel {
    let id: Int
    let title: String
    let color: UIColor
    
    init(id: Int, title: String, color: UIColor) {
        self.id = id
        self.title = title
        self.color = color
    }
}

extension MainHeaderFilterTextModel {
    init(_ filterText: DomainModule.Tag) {
        self.id = filterText.ctID
        self.title = filterText.ctName
        self.color = filterText.ctColor.isEmpty ? .lightGray : UIColor(hex: filterText.ctColor)
    }
}

struct MainHeaderFilterIconModel {
    let icon: UIImage
    let color: UIColor
    
    init(icon: UIImage, color: UIColor) {
        self.icon = icon
        self.color = color
    }
}
