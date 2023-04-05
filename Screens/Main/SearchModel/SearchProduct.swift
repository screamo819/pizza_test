//
//  SearchProduct.swift
//  Qrooto
//
//  Created by Evgeny on 17.11.2022.
//  Copyright © 2022 House of Apps. All rights reserved.
//

import Foundation
import DomainModule

struct SearchProduct {
    let goodsID: Int
    let campaignID: Int
    let name: String
    let link: String
    let actionDateTo: String
}

extension SearchProduct {
    init(_ products: DomainModule.Product) {
        self.goodsID = products.goodsID
        self.campaignID = products.campaignID
        self.name = products.goodsTitle
        self.link = products.goodUrl
        self.actionDateTo = products.actionDateTo
    }
}
