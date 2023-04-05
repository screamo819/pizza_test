//
//  ServerDataStorageAssembly.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import Swinject

public final class ServerDataStorageAssembly: Assembly {
    public init() { }

    public func assemble(container: Container) {
        container.register(DomainServerStorage.self) { resolver in
            ServerDataStorage(resolver.resolve(Storage.self)!)
        }.inObjectScope(.weak)
    }
}
