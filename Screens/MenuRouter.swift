//
//  MenuRouter.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit
import Swinject

final class MainRouter: NSObject {
    private let resolver: Resolver
    private weak var viewController: UIViewController?
    
    init(_ resolver: Resolver) {
        self.resolver = resolver
        
        super.init()
    }
}

// MARK: - ViewAttachable
extension MainRouter: ViewAttachable {
    func attachViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - MainRouting
extension MainRouter: MainRouting {
    func showMain() {
        let viewController = resolver.resolve(TabBarViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
