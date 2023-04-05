//
//  MainSectionModel.swift
//  Qrooto
//
//  Created by Andrey Shemet on 19.11.2021.
//  Copyright © 2021 House of Apps. All rights reserved.
//

import Foundation

class MainSectionModel {
    enum `Type` {
        case rectangle
        case rectangles
        case square
        case squares
        case row
        case empty
    }
    
    enum CellType {
        case rectangle(MainRectangleCellModel)
        case rectangles([MainSmallRectangleCellModel])
        case square(MainSquareCellModel)
        case squares([MainSmallSquareCellModel])
        case row(MainRowCellModel)
        case empty(MainEmptyCellModel)
    }
    
    var type: `Type`
    var title: String
    var logo: String
    var sectionId: Int
    var cells: [CellType]
    var total: Int
    
    init(type:`Type`, title: String, logo: String, sectionId: Int, cells: [MainSectionModel.CellType], total: Int) {
        self.type = type
        self.title = title
        self.logo = logo
        self.sectionId = sectionId
        self.cells = cells
        self.total = total
    }
}

struct MainEmptyCellModel {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}
