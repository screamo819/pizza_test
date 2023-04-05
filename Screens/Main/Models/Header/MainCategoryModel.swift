//
//  MainCategoryModel.swift
//  Qrooto
//
//  Created by Evgeny on 03.02.2023.
//  Copyright © 2023 House of Apps. All rights reserved.
//

import UIKit
import DomainModule

struct MainCategoryModel {
    let id: Int
    let icon: String
    let title: String
    let count: String
}

extension MainCategoryModel {
    init(_ category: DomainModule.CampaignGroup) {
        self.id = category.groupID
        self.icon = category.groupLogo
        self.title = category.groupTitle
        self.count = String(category.total)
    }
}
