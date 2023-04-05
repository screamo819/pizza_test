//
//  MainSmallRectangleBannerCVCell.swift
//  Qrooto
//
//  Created by Andrey Shemet on 19.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit

class MainSmallRectangleBannerCVCell: UICollectionViewCell {
	
	@IBOutlet private var bannerView: UIImageView!
	@IBOutlet private var titleLabel: UILabel!
	@IBOutlet private var descriptionLabel: UILabel!
	@IBOutlet private var favoriteButton: UIButton!
    @IBOutlet private var blurView: UIView!
    @IBOutlet private var adultAgreementLabel: UILabel!
    @IBOutlet private var adultAgeLabel: UILabel!
    var likeAction: (() -> Void)?
    var unLikeAction: (() -> Void)?
    var didTapInfo: (() -> Void)?
    
    @IBAction private func didTapInfoButton(_ sender: UIButton) {
        didTapInfo?()
    }
    
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		layer.cornerRadius = 10
		layer.masksToBounds = true
	}

	func setup(_ model: MainSmallRectangleCellModel) {
		titleLabel.text = model.title
		descriptionLabel.text = model.description
        favoriteButton.isSelected = model.inFavorite
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


private extension MainSmallRectangleBannerCVCell {
	@IBAction func didTapFavoriteButton() {
		favoriteButton.isSelected.toggle()
        
        if favoriteButton.isSelected {
            likeAction?()
        } else {
            unLikeAction?()
        }
	}
}
