//
//  DomainApiService.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import RxSwift

public protocol DomainApiService {
    func getPizzaData() -> Single<[Drink]> 
}
