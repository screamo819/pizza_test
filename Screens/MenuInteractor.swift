//
//  MenuInteractor.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import RxSwift

final class MainInteractor {
    private let apiService: DomainApiService
    
    init(_ apiService: DomainApiService) {
        self.apiService = apiService
    }
    
    func getPizzaData() -> Single<[Drink]> {
        apiService.getPizzaData()
    }
}
