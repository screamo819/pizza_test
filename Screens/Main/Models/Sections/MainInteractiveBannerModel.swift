//
//  MainInteractiveBannerModel.swift
//  Qrooto
//
//  Created by Evgeny on 01.02.2023.
//  Copyright © 2023 House of Apps. All rights reserved.
//

import UIKit
import DomainModule

struct MainInteractiveBannerModel {
    let bgColor: UIColor
    let title: String
    let textBeforeImg: String
    let textBeforeImgColor: UIColor
    let textAfterImg: String
    let textAfterImgColor: UIColor
    let image: URL?
    let actionButtonUrl: String
    let actionButtonTitle: String
    let actionButtonTitleColor: UIColor
    let actionButtonBGColor: UIColor
    let cancelButtonTitle: String
    let cancelButtonTitleColor: UIColor
}

extension MainInteractiveBannerModel {
    init(_ bannerModel: DomainModule.Campaign) {
        self.bgColor = .systemGray6 //bannerModel.bgBannerColor.isEmpty ? .lightGray : UIColor(hex: bannerModel.bgBannerColor)
        self.title = bannerModel.campaignGroupTitle
        self.textBeforeImg = bannerModel.advertiser
        self.textBeforeImgColor = .black //bannerModel.textBeforeImgColor.isEmpty ? .black : UIColor(hex: bannerModel.textBeforeImgColor)
        self.textAfterImg = bannerModel.campaignDescriptionShort
        self.textAfterImgColor = .black //bannerModel.textAfterImgColor.isEmpty ? .black : UIColor(hex: bannerModel.textAfterImgColor)
        self.image = URL(string: bannerModel.campaignBackground)
        self.actionButtonUrl = bannerModel.link1URL
        self.actionButtonTitle = bannerModel.link1Title
        self.actionButtonBGColor = .systemBlue //bannerModel.bgButtonColor.isEmpty ? .lightGray : UIColor(hex: bannerModel.bgButtonColor)
        self.actionButtonTitleColor = .black //bannerModel.actionButtonTitleColor.isEmpty ? .black : UIColor(hex: bannerModel.actionButtonTitleColor)
        self.cancelButtonTitle = "Не сейчас" //bannerModel.cancelButtonTitle.isEmpty ? "Не сейчас" : bannerModel.cancelButtonTitle
        self.cancelButtonTitleColor = .gray //bannerModel.cancelButtonTitleColor.isEmpty ? .black : UIColor(hex: bannerModel.cancelButtonTitleColor)
    }
}
