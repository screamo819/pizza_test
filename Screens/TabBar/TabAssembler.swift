//
//  TabAssembler.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import Swinject

final class TabBarAssembly: Assembly {
    func assemble(container: Container) {
        registerTabBarModule(in: container)
    }
}

// MARK: - Privates
private extension TabBarAssembly {
    func registerTabBarModule(in container: Container) {
        container.register(TabBarRouting.self) { (resolver) in
            TabBarRouter(resolver)
        }

        container.register(TabBarInteractor.self) { (resolver) in
            TabBarInteractor()
        }
        
        container.register(TabBarViewModel.self) { (resolver, items: [TabBarItemModel]) in
            let router = resolver.resolve(TabBarRouting.self)!
            let iteractor = resolver.resolve(TabBarInteractor.self)!
            return TabBarViewModel(router, iteractor, items)
        }

        container.register(TabBarViewController.self) { (resolver) in
            let viewController = R.storyboard.tabBarViewController.tabViewController()!
            
            let items: [TabBarItemModel] = [
                .init(type: .main),
                .init(type: .contacts),
                .init(type: .profile),
                .init(type: .trash)
            ]

            let viewModel = resolver.resolve(TabBarViewModel.self, argument: items)!

            viewController.input = viewModel
            viewController.output = viewModel

            for item in items {
                let itemViewController: UIViewController?
                
                switch item.type {
                case .main:
                    let viewController = resolver.resolve(
                        NavigationController.self,
                        arguments:
                            resolver.resolve(MainViewController.self) as! UIViewController,
                            NavigationController.Style.standart
                    )!
                    itemViewController = viewController
                case .contacts:
                    let viewController = resolver.resolve(
                        NavigationController.self,
                        arguments:
                            resolver.resolve(MainViewController.self) as! UIViewController,
                            NavigationController.Style.standart
                    )!
                    itemViewController = viewController
                case .profile:
                    let viewController = resolver.resolve(
                        NavigationController.self,
                        arguments:
                            resolver.resolve(MainViewController.self) as! UIViewController,
                            NavigationController.Style.standart
                    )!
                    itemViewController = viewController
                case .trash:
                    let viewController = resolver.resolve(
                        NavigationController.self,
                        arguments:
                            resolver.resolve(MainViewController.self) as! UIViewController,
                            NavigationController.Style.standart
                    )!
                    itemViewController = viewController
                default:
                    itemViewController = nil
                }
                
                if let itemViewController = itemViewController {
                    viewController.append(itemViewController, for: item.type)
                }
            }
            
            return viewController
        }.initCompleted { resolver, viewController in
            let router = resolver.resolve(TabBarRouting.self)!
            router.attachViewController(viewController)
        }
    }
}
