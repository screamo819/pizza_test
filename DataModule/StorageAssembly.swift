//
//  StorageAssembly.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import Swinject

public final class StorageAssembly: Assembly {
    private let assemblies: [Assembly] = [
        ServerDataStorageAssembly()
    ]

    public init() { }

    public func assemble(container: Container) {
        container.register(Storage.self) { _ in
            Storage(UserDefaults(suiteName: "group.ru.pizza.test") ?? .standard)
        }.inObjectScope(.weak)

        assemblies
            .forEach { $0.assemble(container: container) }
    }
}
