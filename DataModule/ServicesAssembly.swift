//
//  ServicesAssembly.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import Swinject

public final class ServicesAssembly: Assembly {
    private let assemblies: [Assembly] = [
        DataApiServiceAssembly()
    ]

    public init() { }

    public func assemble(container: Container) {
        assemblies
            .forEach { $0.assemble(container: container) }
    }
}
