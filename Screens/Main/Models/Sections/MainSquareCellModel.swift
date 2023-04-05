//
//  MainSquareCellModel.swift
//  Qrooto
//
//  Created by Andrey Shemet on 19.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit
import DomainModule

struct MainSquareCellModel {
	let id: Int
	let tag: String
	let title: String
	let description: String
	let image: URL?
	let actionTitle: String
    let linkUrl: String
	var inFavorite: Bool
    let campaignUrl: String
    var didTapLike: (() -> Void)?
    var didTapUnlike: (() -> Void)?
    var didTapActionButton: (() -> Void)?
    let adultAgreement: Int
}

extension MainSquareCellModel {
    init(_ discount: DomainModule.Campaign) {
        self.id = discount.campaignID
        self.tag = discount.advertiser
        self.title = discount.revenue
        self.description = discount.campaignTitleShort
        self.image = URL(string: discount.campaignBackground)
        self.inFavorite = discount.liked
        self.actionTitle = discount.link1Title
        self.linkUrl = discount.link1URL
        self.campaignUrl = discount.campaignURL
        self.adultAgreement = discount.campaignAdultsOnly
    }
}
