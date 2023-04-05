//
//  MainSmallSquareBannerTVCell.swift
//  Qrooto
//
//  Created by Andrey Shemet on 19.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import UIKit

class MainSmallSquareBannerCVCell: UICollectionViewCell {
	@IBOutlet private var bannerView: UIImageView!
	@IBOutlet private var titleLabel: UILabel!
	@IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var blurView: UIView!
    @IBOutlet private var adultAgreementLabel: UILabel!
    @IBOutlet private var adultAgeLabel: UILabel!
    @IBOutlet private var labelStackView: UIStackView!
    var didTapInfo: (() -> Void)?
    
    @IBAction private func didTapInfoButton(_ sender: UIButton) {
        didTapInfo?()
    }
    
    let titleBlur = BlurredLabel()
    let descriptionBlur = BlurredLabel()
    
	override func awakeFromNib() {
		super.awakeFromNib()
		bannerView.layer.cornerRadius = 10
		bannerView.layer.masksToBounds = true
	}
	
	func setup(_ model: MainSmallSquareCellModel) {
		titleLabel.text = model.title
		descriptionLabel.text = model.description
        
        if let url = model.image {
            self.bannerView.setImage(with: url, placeholder: "")
        } else {
            self.bannerView.image = R.image.icLogoQrooto()
        }
        
        setupBlur()
        guard Main.shared?.states.userIsNotAdult ?? true else { return }
        if model.adultAgreement == 1 {
            titleBlur.text = model.title
            descriptionBlur.text = model.description
            showBlur()
        }
	}
    
    func showBlur() {
        blurView.isHidden = false
        adultAgreementLabel.isHidden = false
        adultAgeLabel.isHidden = false
        
        titleLabel.isHidden = true
        descriptionLabel.isHidden = true
       
        titleBlur.isBlurring = true
        descriptionBlur.isBlurring = true
    }
    
    func setupBlur() {
        blurView.applyBlurEffect()
        blurView.layer.cornerRadius = 10
        blurView.layer.masksToBounds = true
        blurView.isHidden = true
        adultAgreementLabel.text = R.string.localizable.mainBannersAdultTitle()
        adultAgreementLabel.isHidden = true
        adultAgeLabel.isHidden = true
        
        titleBlur.textColor = .black
        titleBlur.frame = titleLabel.frame
        titleBlur.clipsToBounds = false
       
        descriptionBlur.textColor = .black
        descriptionBlur.frame = descriptionLabel.frame
        descriptionBlur.clipsToBounds = false
        
        labelStackView.addSubview(titleBlur)
        labelStackView.addSubview(descriptionBlur)
    }
}
