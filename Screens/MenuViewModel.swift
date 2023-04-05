//
//  MenuViewModel.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel {
    private let disposeBag = DisposeBag()
    //Input
    private let loadingRelay: BehaviorRelay<Bool> = .init(value: false)
    private let filtersRelay: BehaviorRelay<[FilterModel]?> = .init(value: nil)
    private let itemsRelay: BehaviorRelay<[ItemModel]?> = .init(value: nil)
    //Output
    private let didAppearSubject: PublishSubject<Void> = .init()
    private let didTapFilterSubject: PublishSubject<Int> = .init()
    private let didTapItemSubject: PublishSubject<Int> = .init()
    private let didTapCityButtonSubject: PublishSubject<Void> = .init()
    //Internal
    private let router: MainRouting
    private let interactor: MainInteractor
    private var allLoaded = false
    
    init(_ router: MainRouting, _ interactor: MainInteractor) {
        self.router = router
        self.interactor = interactor
        
        bind()
    }
}

// MARK: - StartViewInput
extension MainViewModel: MainViewInput {
    var loading: Observable<Bool> { loadingRelay.asObservable() }
    var filters: Observable<[FilterModel]?> { filtersRelay.asObservable() }
    var items: Observable<[ItemModel]?> { itemsRelay.asObservable() }
}

// MARK: - StartViewOutput
extension MainViewModel: MainViewOutput {
    var didAppear: AnyObserver<Void> { didAppearSubject.asObserver() }
    var didTapFilter: AnyObserver<Int> { didTapFilterSubject.asObserver() }
    var didTapItem: AnyObserver<Int> { didTapItemSubject.asObserver() }
    var didTapCity: AnyObserver<Void> { didTapCityButtonSubject.asObserver() }
}

// MARK: - Private
private extension MainViewModel {
    func bind() {
        loadingRelay.accept(true)
        
        didAppearSubject
            .subscribe(
                onNext: { [weak self] (_) in
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.25) { [weak self] in
                        guard let self = self else { return }
                        self.setupNotifications(0)
                        self.loadingRelay.accept(false)
                    }
                }
            )
            .disposed(by: disposeBag)
        
        didTapCityButtonSubject
            .subscribe(
                onNext: { [weak self] (_) in
                    print("DID TAP CITY BUTTON")
                }
            )
            .disposed(by: disposeBag)
        
        didTapFilterSubject
            .subscribe(
                onNext: { [weak self] (index) in
                    print("did tap filter item")
                }
            )
            .disposed(by: disposeBag)
        
        didTapItemSubject
            .subscribe(
                onNext: { [weak self] (index) in
                   print("did tap pizza item")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func setupNotifications(_ offset: Int) {
        guard offset == 0 || !allLoaded else { return }
        self.loadingRelay.accept(true)
        let limit = 20
        let tagId = filterTagRelay.value ?? 0
        
        interactor.getNotifications(offset: offset, limit: limit, tagId: tagId)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] response in
                    guard let self = self else { return }
                    let filterItems = response.tags.compactMap({ NotificationsFilterModel($0) })
                    self.filtersRelay.accept(filterItems)
                    
                    self.allLoaded = limit > response.notifications.count
                    self.loadingRelay.accept(false)
                    var notifItems: [NotificationsItemModel] = offset == 0 ? [] : self.notificationItemsRelay.value!
                    notifItems += response.notifications.compactMap({ NotificationsItemModel($0) })
                    self.notificationItemsRelay.accept(notifItems)
                    self.itemsIsEmptyRelay.accept(notifItems.isEmpty)
                    
                    self.loadingRelay.accept(false)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func getPizza() {
        interactor.getPizzaData()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] pizzaData in
                    guard let self = self else { return }
                    
                    let item = pizzaData.
                    items += response({ ItemModel($0) })
                    self.notificationItemsRelay.accept(items)
                    
                    print(" - - - PIZZA DATA - - - ") },
                onError: { _ in print(" !!!! ERROR !!! ") }
            )
            .disposed(by: disposeBag)
    }
}
