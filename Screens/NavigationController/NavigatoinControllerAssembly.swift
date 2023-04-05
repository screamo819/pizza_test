//
//  NavigatoinControllerAssembly.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Swinject

final class NavigationControllerAssembly: Assembly {
    func assemble(container: Container) {
        registerNavigationControllerModule(in: container)
    }
}

// MARK: - Privates
private extension NavigationControllerAssembly {
    func registerNavigationControllerModule(in container: Container) {
        container.register(NavigationController.self) { (_, rootViewController: UIViewController, style: NavigationController.Style) in
            NavigationController.make(
                rootViewController: rootViewController,
                style: style
            )
        }
        .inObjectScope(.transient)
    }
}
