//
//  MenuAssembly.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//


import Swinject

final class MainAssembly: Assembly {
    func assemble(container: Container) {
        registerMainModule(in: container)
    }
}

// MARK: - Privates
private extension MainAssembly {
    func registerMainModule(in container: Container) {
        container.register(MainRouting.self) { (resolver) in
            MainRouter(resolver)
        }

        container.register(MainInteractor.self) { (resolver) in
            MainInteractor(
                resolver.resolve(DomainApiService.self)!
            )
        }
        
        container.register(MainViewModel.self) { (resolver) in
            let router = resolver.resolve(MainRouting.self)!
            let iteractor = resolver.resolve(MainInteractor.self)!
            return MainViewModel(router, iteractor)
        }

        container.register(MainViewController.self) { (resolver) in
            let viewController = R.storyboard.mainViewController.mainViewController()!
            let viewModel = resolver.resolve(MainViewModel.self)!

            viewController.input = viewModel
            viewController.output = viewModel
            
            return viewController
        }.initCompleted { resolver, viewController in
            let router = resolver.resolve(MainRouting.self)!
            router.attachViewController(viewController)
        }
    }
}
