//
//  TabBarItemModel.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit

struct TabBarItemModel {
    enum `Type`: Hashable {
        case main
        case contacts
        case profile
        case trash
    }
    
    var image: UIImage
    let highlightedImage: UIImage
    let title: String?
    let type: `Type`
    
    init(image: UIImage,
         highlightedImage: UIImage? = nil,
         title: String? = nil,
         type: `Type`) {
        self.image = image
        self.highlightedImage = highlightedImage ?? image
        self.title = title
        self.type = type
    }
    
    init(type: `Type`) {
        switch type {
        case .main:
            self.init(
                image: R.image.menu()!,
                title: "Меню",
                type: type
            )
        case .contacts:
            self.init(
                image: R.image.contacts()!,
                title: "Контакты",
                type: type
            )
      
        case .profile:
            self.init(
                image: R.image.profile()!,
                title: "Профиль",
                type: type
            )
        case .trash:
            self.init(
                image: R.image.trash()!,
                title: "Корзина",
                type: type
            )
        }
    }
}
