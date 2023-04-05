//
//	MainInteractor.swift
//	Qrooto
//
//	Created by Andrey Shemet on 16.11.2021.
//	Copyright (c) 2021 House of Apps. All rights reserved.
//

import DomainModule
import RxSwift

final class MainInteractor {
	private let userService: DomainModule.UserService
    private let financeService: DomainModule.FinanceService
    private let discountService: DomainModule.DiscountService
    private let notificationService: DomainModule.NotificationsService
	
    init(_ userService: DomainModule.UserService,
         _ financeService: DomainModule.FinanceService,
         _ discountService: DomainModule.DiscountService,
         _ notificationService: DomainModule.NotificationsService) {
		self.userService = userService
        self.financeService = financeService
        self.discountService = discountService
        self.notificationService = notificationService
	}
    
    func getCountOfNotifications() -> Single<Int> {
            notificationService.getNew()
    }
    
    func subscribeToNotify() -> Observable<Int?> {
        notificationService.subscribeToNotifyCount()
    }
	
	func subscribeToCurrentUserChanges() -> Observable<DomainModule.User?> {
		userService.subscribeToCurrentUserChanges()
	}
    
    func getUserBalance() -> Single<AccountBalance> {
        return financeService.getBalance()
    }
    
    func subscribeToChangeCashback() -> Observable<AccountBalance?> {
        financeService.subscribe()
    }
    
    func fetchCampaigns(offset: Int? = nil, limit: Int? = nil, liked: Int? = nil, tagId: Int? = nil, search: String? = nil) -> (Single<MainData>, Single<Platform>) {
        discountService.fetchCampaigns(.init(offset: offset, limit: limit, liked: liked, tagId: tagId, search: search))
    }
    
    func getTopCampaigns() -> (Single<MainData>, Single<Platform>) {
        discountService.getTopCampaings()
    }
    
    func getCampaignGroups() -> Single<MainCampaignGroup> {
        discountService.getCampaignGroup()
    }
    
    func sendLike(campaignId: Int) -> Completable {
        discountService.likeCampaign(.init(campaignId: campaignId))
    }
    
    func sendUnlike(campaignId: Int) -> Completable {
        discountService.unlikeCampaign(.init(campaignId: campaignId))
    }
    
    func sendPushClick(_ campaignID: Int?) -> Completable {
        let clientVersion = Main.shared?.clientVersion() ?? "Version undefined"
        return discountService.pushClickCounter(.init(campaignID, clientVersion))
    }
    
    func confirmAdultAge() -> Completable {
        userService.adultAgree()
    }
    
    func getPizzaData() -> Completable {
        financeService.getPizzaData()
    }
}
