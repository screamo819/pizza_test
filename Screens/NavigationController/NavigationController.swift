//
//  NavigationController.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class NavigationController: UINavigationController {
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationBar.largeTitleItems(trailing: [])
        super.pushViewController(viewController, animated: animated)
    }
}

private extension NavigationController { }

extension NavigationController {
    enum Style {
        case standart, clear
    }
    
    class func make(rootViewController: UIViewController, style: Style = .standart) -> NavigationController {
        let navigationController = NavigationController(
            rootViewController: rootViewController
        )
        
        navigationController.navigationBar.tintColor = R.color.orange()
        navigationController.navigationBar.prefersLargeTitles = true
        
        switch style {
        case .standart:
            break
        case .clear:
            navigationController.navigationBar.barTintColor = .white
            navigationController.navigationBar.shadowImage = UIImage()
        }
        
        navigationController.interactivePopGestureRecognizer?.delegate = nil
        
        return navigationController
    }
}
