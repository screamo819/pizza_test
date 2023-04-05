//
//  TabViewController.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit
import RxSwift

final class TabBarViewController: UITabBarController {
    private let disposeBag = DisposeBag()
    var input: TabBarViewInput!
    var output: TabBarViewOutput!
    fileprivate var customTabBar: TabBar?
    fileprivate var customTabBarBottomOffset: NSLayoutConstraint?
    fileprivate var itemViewControllers: [TabBarItemModel.`Type`: UIViewController] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        localizeStrings()
        setupView()
        setupRx()
    }
    
    func append(_ viewController: UIViewController, for type: TabBarItemModel.`Type`) {
        let safeAreaBottomInset = view.safeAreaInsets.bottom + 50
        viewController.additionalSafeAreaInsets.bottom = safeAreaBottomInset
        itemViewControllers[type] = viewController
        self.viewControllers = (self.viewControllers ?? []) + [viewController]
    }
    
    func hideTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            guard let self = self else { return }
            guard let customTabBar = self.customTabBar else { return }
            if let _bottomOffset = self.customTabBarBottomOffset, _bottomOffset.constant == 0 {
                _bottomOffset.constant = customTabBar.frame.height
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                    self.viewControllers?.forEach({ $0.additionalSafeAreaInsets.bottom -= self.view.safeAreaInsets.bottom + 50 })
                    self.view.layoutIfNeeded()
                }, completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.customTabBar?.isHidden = true
                })
            }
        }
    }
    
    func showTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            guard let self = self else { return }
            guard let customTabBar = self.customTabBar else { return }
            
            if let _bottomOffset = self.customTabBarBottomOffset, _bottomOffset.constant != 0 {
                _bottomOffset.constant = 0
                customTabBar.isHidden = false
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                    self.viewControllers?.forEach({ $0.additionalSafeAreaInsets.bottom += self.view.safeAreaInsets.bottom + 50 })
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
  
    func showMain() {
        self.customTabBar?.selectedIndex = 0
        self.selectedViewController = self.itemViewControllers[.main]
    }
 
}

// MARK: - Private
private extension TabBarViewController {
    func localizeStrings() { }
    
    func setupView() {
        self.tabBar.isHidden = true
        let tabBar = R.nib.dashboardTabBar(owner: nil, options: nil)!
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tabBar)
        let tabBarBottomOffset = tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        view.addConstraints([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarBottomOffset
        ])
        
        tabBar.setup(input.items)
        tabBar.selectedIndex = 0
        
        customTabBarBottomOffset = tabBarBottomOffset
        customTabBar = tabBar
    }
    
    func setupRx() {
        input.loading
            .subscribe(
                onNext: { [weak self] (isLoading) in
                    
                }
            )
            .disposed(by: disposeBag)
        
        customTabBar?.rx.controlEvent([.touchUpInside])
            .debug()
            .subscribe(
                onNext: { [weak self] (index) in
                    guard let self = self else { return }
                    
                    if index >= 0 {
                        let type = self.input.items[index].type
                        switch type {
                        default:
                            self.customTabBar?.selectedIndex = index
                            self.selectedViewController = self.itemViewControllers[type]
                        }
                    }
                }
            )
            .disposed(by: disposeBag)
    }
}
