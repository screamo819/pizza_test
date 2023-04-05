//
//  TabViewModel.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import RxSwift
import RxCocoa

final class TabBarViewModel {
    private let disposeBag = DisposeBag()
    //Input
    private let loadingRelay: BehaviorRelay<Bool> = .init(value: false)
    var items: [TabBarItemModel] = []
    //Output
    private let didTapScannerSubject: PublishSubject<Void> = .init()
    //Internal
    private let router: TabBarRouting
    private let interactor: TabBarInteractor
    
    init(_ router: TabBarRouting, _ interactor: TabBarInteractor, _ items: [TabBarItemModel]) {
        self.router = router
        self.interactor = interactor
        self.items = items
        bind()
    }
}

// MARK: - TabBarViewInput
extension TabBarViewModel: TabBarViewInput {
    var loading: Observable<Bool> { loadingRelay.asObservable() }
}

// MARK: - TabBarViewOutput
extension TabBarViewModel: TabBarViewOutput {
    var didTapScanner: AnyObserver<Void> { didTapScannerSubject.asObserver() }
}

// MARK: - Private
private extension TabBarViewModel {
    func bind() {
        didTapScannerSubject
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                
                }
            )
            .disposed(by: disposeBag)
      
    }
}
