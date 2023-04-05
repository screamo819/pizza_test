//
//  TabContract.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import RxSwift

protocol TabBarViewInput {
    var loading: Observable<Bool> { get }
    var items: [TabBarItemModel] { get set }
}

protocol TabBarViewOutput {
    var didTapScanner: AnyObserver<Void> { get }
}

protocol TabBarRouting: ViewAttachable {
    
}
