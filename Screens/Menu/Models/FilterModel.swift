//
//  FilterModel.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import UIKit

struct FilterModel {
    let id: Int
    let title: String
    let color: UIColor
    
    init(id: Int, title: String, color: UIColor) {
        self.id = id
        self.title = title
        self.color = color
    }
}
