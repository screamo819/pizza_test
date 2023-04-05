//
//  DataApiService.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import RxSwift
import RxCocoa

final class DataApiService: DomainApiService {
    
    private let networkService: NetworkService

    init(_ networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func getPizzaData() -> Single<[Drink]>  {
        networkService.execute(
            Api.getPizza,
            with: Api.Response.PizzaData.self
        )
        .map { $0.drinks }
    }
}
