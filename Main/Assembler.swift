//
//  Assembler.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 04.04.2023.
//

import Foundation
import Swinject

extension Main {
    final class Assembler {
        lazy var assembler = Swinject.Assembler(Presentation().assemblies + Domain().assemblies + Data().assemblies)

        var resolver: Resolver {
            assembler.resolver
        }

        private struct Presentation {
            var assemblies: [Assembly] = [
                NavigationControllerAssembly(),
                TabBarAssembly(),
                MainAssembly()
            ]
        }

        private struct Domain {
            var assemblies: [Assembly] = []
        }

        private struct Data {
            var assemblies: [Assembly] = [
                DataAssembly(false, .init(
                    apiPath: Constants.apiPath
                ))
            ]
        }
    }
}
