//
//  DataAssembly.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import Swinject

public final class DataAssembly: Assembly {
    private let assemblies: [Assembly] = [
        NetworkAssembly(),
        ServerDataStorageAssembly(),
        ServicesAssembly()
    ]

    private let forTests: Bool
    private let paths: ApiPaths

    public init(_ forTests: Bool = false, _ paths: ApiPaths) {
        self.forTests = forTests
        self.paths = paths
    }

    public func assemble(container: Container) {
        assemblies
            .forEach { $0.assemble(container: container) }

        var serverStorage = container.resolve(DomainServerStorage.self)!

        serverStorage.apiPath = paths.apiPath
        
        assembleNetworkService(container, serverStorage.apiPath)
    }

}

private extension DataAssembly {
    func assembleNetworkService(_ container: Container, _ apiPath: String?) {
        container.register(NetworkService.self, name: apiPath, factory: { (resolver) in
            resolver.resolve(
                NetworkService.self,
                arguments:
                    self.forTests,
                    apiPath ?? ""
            )!
        })
        .inObjectScope(.weak)
    }
}

public extension DataAssembly {
    struct ApiPaths {
        let apiPath: String
        public init(apiPath: String) {
            self.apiPath = apiPath
        }
    }
}
