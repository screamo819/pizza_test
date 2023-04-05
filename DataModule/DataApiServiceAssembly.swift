//
//  DataApiServiceAssembly.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import Swinject

public final class DataApiServiceAssembly: Assembly {
    private let assemblies: [Assembly] = []

    public init() { }

    public func assemble(container: Container) {
        container.register(DomainApiService.self) { resolver in
            DataApiService(
                resolver.resolve(
                    NetworkService.self,
                    name: resolver.resolve(DomainServerStorage.self)!.apiPath ?? ""
                )!
            )
        }.inObjectScope(.weak)

        assemblies
            .forEach { $0.assemble(container: container) }
    }
}
