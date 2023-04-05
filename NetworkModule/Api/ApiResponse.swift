//
//  ApiResponse.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation

public extension Api.Response {
    struct PizzaData: Decodable {
        public let drinks: [Drink]
        
        enum CodingKeys: String, CodingKey {
            case drinks
        }
    }
}
