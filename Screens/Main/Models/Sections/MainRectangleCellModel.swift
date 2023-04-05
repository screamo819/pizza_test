//
//  MainRectangleCellModel.swift
//  Qrooto
//
//  Created by Andrey Shemet on 19.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit
import DomainModule

struct MainRectangleCellModel {
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

extension MainRectangleCellModel {
    init(_ discount: DomainModule.Campaign) {
        self.id = discount.campaignID
        self.tag = discount.advertiser
        self.title = discount.revenue
        self.description = discount.campaignTitleShort
        self.image = URL(string: discount.campaignBackground)
        self.inFavorite = discount.liked
        self.campaignUrl = discount.campaignURL
        self.linkUrl = discount.link1URL
        self.adultAgreement = discount.campaignAdultsOnly
    }
}
