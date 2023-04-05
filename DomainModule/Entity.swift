//
//  Entity.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation

public struct Drink: Decodable {
    public let drink: String
    public let image: String
    public let idDrink: String
    public let description: String
    
    enum CodingKeys: String, CodingKey {
        case drink = "strDrink"
        case image = "strDrinkThumb"
        case idDrink
        case description
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idDrink = (try? container.decode(String.self, forKey: .idDrink)) ?? ""
        image = (try? container.decode(String.self, forKey: .image)) ?? ""
        drink = (try? container.decode(String.self, forKey: .drink)) ?? ""
        description = (try? container.decode(String.self, forKey: .description)) ?? "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус"
    }
}
