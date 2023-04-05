//
//  Storage.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation

public class Storage: DomainStorage {
    
    private let userDefaults: UserDefaults
    
    init(_ userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    public func get(forKey key: String) -> Any? {
        userDefaults.value(forKey: key)
    }
    
    public func set(_ value: Any?, forKey key: String) {
        if let value = value {
            userDefaults.setValue(value, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
    }
}
