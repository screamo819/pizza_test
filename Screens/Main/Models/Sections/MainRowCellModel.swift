//
//  MainRowCellModel.swift
//  Qrooto
//
//  Created by Evgeny on 25.01.2023.
//  Copyright © 2023 House of Apps. All rights reserved.
//

import Foundation
import DomainModule

struct MainRowCellModel {
    let id: Int
    let tag: String
    let title: String
    let description: String
    let image: URL?
    var inFavorite: Bool
    let campaignUrl: String
    let linkUrl: String
    var didTapLike: (() -> Void)?
    var didTapUnlike: (() -> Void)?
    let adultAgreement: Int
}

extension MainRowCellModel {
    init(_ discount: DomainModule.Campaign) {
        self.id = discount.campaignID
        self.tag = discount.advertiser
        self.title = discount.revenue
        self.description = discount.campaignTitleShort
        self.image = URL(string: discount.campaignLogo)
        self.inFavorite = discount.liked
        self.campaignUrl = discount.campaignURL
        self.linkUrl = discount.link1URL
        self.adultAgreement = discount.campaignAdultsOnly
    }
}
