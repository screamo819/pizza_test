//
//  TabRouter.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit
import Swinject

final class TabBarRouter {
    private let resolver: Resolver
    private weak var viewController: UIViewController?

    init(_ resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: - ViewAttachable
extension TabBarRouter: ViewAttachable {
    func attachViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - Routing
extension TabBarRouter: TabBarRouting {

}
