//
//  JSONDecoder.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation

extension JSONDecoder {
    static var iso8601compatible: JSONDecoder {
        return JSONDecoder(dateDecodingStrategy: .iso8601)
    }

    convenience init(dateDecodingStrategy: DateDecodingStrategy) {
        self.init()

        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
