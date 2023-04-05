//
//  MainSquareBannerTVCell.swift
//  Qrooto
//
//  Created by Andrey Shemet on 19.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit

class MainSquareBannerTVCell: MainBaseTVCell {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var bannerView: UIImageView!
    @IBOutlet private var tagLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var favoriteButton: UIButton!
    @IBOutlet private var actionButton: UIButton!
    @IBOutlet private var blurView: UIView!
    @IBOutlet private var adultAgreementLabel: UILabel!
    @IBOutlet private var adultAgeLabel: UILabel!
    private var inFavorite: Bool = false
    var likeAction: (() -> Void)?
    var unLikeAction: (() -> Void)?
    var didTapActionButton: (() -> Void)?
    var didTapInfo: (() -> Void)?
    
    private var linkUrl: String = ""
    
    @IBAction func tapAction(_ sender: UIButton) {
        didTapActionButton?()
    }
    
    @IBAction private func didTapInfoButton(_ sender: UIButton) {
        didTapInfo?()
    }
	
	override func awakeFromNib() {
		super.awakeFromNib()
		containerView.layer.cornerRadius = 10
		containerView.layer.masksToBounds = true
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.black.cgColor
	}
	
	func setup(_ model: MainSquareCellModel) {
		tagLabel.text = model.tag
		titleLabel.text = model.title
		descriptionLabel.text = model.description
		actionButton.setTitle(model.actionTitle, for: .normal)
        actionButton.isHidden = model.actionTitle.isEmpty || model.linkUrl.isEmpty
        linkUrl = model.linkUrl
		favoriteButton.isSelected = model.inFavorite
        inFavorite = model.inFavorite
        likeAction = model.didTapLike
        unLikeAction = model.didTapUnlike
        
        if let url = model.image {
            self.bannerView.setImage(with: url, placeholder: "")
        } else {
            self.bannerView.image = R.image.icLogoQrooto()
        }
        
        setupBlur()
        guard Main.shared?.states.userIsNotAdult ?? true else { return }
        if model.adultAgreement == 1 {
            showBlur()
        }
    }
    
    func showBlur() {
        blurView.isHidden = false
        adultAgreementLabel.isHidden = false
        adultAgeLabel.isHidden = false
    }
    
    func setupBlur() {
        blurView.applyBlurEffect()
        blurView.layer.cornerRadius = 10
        blurView.layer.masksToBounds = true
        blurView.isHidden = true
        adultAgreementLabel.text = R.string.localizable.mainBannersAdultTitle()
        adultAgreementLabel.isHidden = true
        adultAgeLabel.isHidden = true
    }
}

private extension MainSquareBannerTVCell {
	@IBAction func didTapFavoriteButton() {
		favoriteButton.isSelected.toggle()
        
        if favoriteButton.isSelected {
            likeAction?()
        } else {
            unLikeAction?()
        }
	}
}
