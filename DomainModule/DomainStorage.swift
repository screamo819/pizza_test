//
//  DomainStorage.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation

public protocol DomainStorage {
    func get(forKey key: String) -> Any?
    func set(_ value: Any?, forKey key: String)
}
