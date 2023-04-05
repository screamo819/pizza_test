//
//MainContract.swift
//Qrooto
//
//Created by Andrey Shemet on 16.11.2021.
//Copyright (c) 2021 House of Apps. All rights reserved.
//

import RxSwift

protocol MainViewInput {
	var loading: Observable<Bool> { get }
	var avatar: Observable<UIImage?> { get }
    var cashback: Observable<String?> { get }
	var header: Observable<MainHeaderModel?> { get }
	var sections: [MainSectionModel] { get }
	var reloadSections: Observable<Void> { get }
    var filters: [MainHeaderFilterType] { get }
    var categories: [MainCategoryModel] { get }
    var notificationIsEmpty: Observable<Bool> { get }
    var userAdultAgreement: Observable<Int> { get }
    var bannerModel: Observable<MainInteractiveBannerModel?> { get }
}

protocol MainViewOutput {
	var didAppear: AnyObserver<Void> { get }
	var didTapWallet: AnyObserver<Void> { get }
	var didTapAccount: AnyObserver<Void> { get }
    var didTapSearchCancel: AnyObserver<Void> { get }
	var didTapItem: AnyObserver<(IndexPath, Int?)> { get }
    var willDisplayItem: AnyObserver<IndexPath> { get }
    var filterItemSelected: AnyObserver<Int> { get }
    var categoryItemSelected: AnyObserver<Int> { get }
    var didTapLikeOnDiscount: AnyObserver<(IndexPath, Int?)> { get }
    var didTapUnlikeOnDiscount: AnyObserver<(IndexPath, Int?)> { get }
    var didTapLinkButton: AnyObserver<(IndexPath, Int?)> { get }
    var didTapSectionButton: AnyObserver<Int?> { get }
    var didTapInteractiveActionButton: AnyObserver<Void> { get }
    var didTapItemInfoButton: AnyObserver<(IndexPath, Int?)> { get }
    var searchText: AnyObserver<String?> { get }
    var didTapNotifyButton: AnyObserver<Void> { get }
}

protocol MainRouting: ViewAttachable, AlertRouting {
	func showProfile()
    func showInterfaceTutorial()
	func showWallet()
    func showDiscount(_ id: Int)
    func showSupport()
    func showSignIn()
    func showTicket(_ ticketId: Int)
    func showNotify()
    func showChat()
    func showMoreDiscounts(_ sectionId: Int)
    // routing for open deeplinks
    func showProductCard(_ campaignId: Int, _ productId: Int, _ campaingTitle: String)
    func showProductList(_ campaignId: Int, _ campaingTitle: String)
    func showPersonalInfo()
    func showCosts(_ categoryId: Int)
    func showStoreCosts(_ retailer: (Int, String))
    func showTickets()
    func showOrders()
    func showTicketsOnline()
    func showPayments()
    func showPaymentOutcome(_ id: Int)
    func showPaymentRequest(_ id: Int)
    func inviteFriend()
    func showProfy()
    func showScanQR()
    func showMainCosts()
}
