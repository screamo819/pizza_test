//
//  ItemModel.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import UIKit

struct ItemModel {
    let id: Int
    let title: String
    let description: NSAttributedString?
    let pizzaBanner: URL?
    
    init(id: Int, title: String, description: NSAttributedString?, pizzaBanner: URL?) {
        self.id = id
        self.title = title
        self.description = description
        self.pizzaBanner = pizzaBanner
    }
}

extension ItemModel {
    init(_ items: Drink) {
        self.id = items.idDrink
        self.title = items.drink
        self.description = NSAttributedString(textWithHTML: items.description)
        self.pizzaBanner = URL(string: items.image)
    }
}
