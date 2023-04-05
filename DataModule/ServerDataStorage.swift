//
//  ServerDataStorage.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation

class ServerDataStorage: DomainServerStorage {
    private enum Keys: String {
        case apiPath
    }

    private let storage: Storage

    init(_ storage: Storage) {
        self.storage = storage
    }
}

extension ServerDataStorage {
    public var apiPath: String? {
        get {
            storage.get(forKey: ServerDataStorage.Keys.apiPath.rawValue) as? String
        }
        set {
            storage.set(newValue, forKey: ServerDataStorage.Keys.apiPath.rawValue)
        }
    }
}
