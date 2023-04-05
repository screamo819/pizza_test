//
//  MenuContract.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import RxSwift

protocol MainViewInput {
    var loading: Observable<Bool> { get }
    var filters: Observable<[NotificationsFilterModel]?> { get }
    var items: Observable<[ItemModel]?> { get }
}

protocol MainViewOutput {
    var didAppear: AnyObserver<Void> { get }
    var didTapFilter: AnyObserver<Int> { get }
    var didTapItem: AnyObserver<Int> { get }
    var didTapCity: AnyObserver<Void> { get }
}

protocol MainRouting: ViewAttachable {
    func showMain()
}
