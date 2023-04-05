//
//  Router.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 04.04.2023.
//

import UIKit

extension Main {
    class Router {
        private let window: UIWindow
        private let assembler: Main.Assembler

        init(_ window: UIWindow, _ assembler: Main.Assembler) {
            self.window = window
            self.assembler = assembler
        }

        func start() {
            let vc = assembler.resolver.resolve(TabBarViewController.self)!
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
}

import UIKit

protocol ViewAttachable {
    func attachViewController(_ viewController: UIViewController)
}
