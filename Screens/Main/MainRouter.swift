//
//	MainRouter.swift
//	Qrooto
//
//	Created by Andrey Shemet on 16.11.2021.
//	Copyright (c) 2021 House of Apps. All rights reserved.
//

import DomainModule
import UIKit
import Swinject

final class MainRouter: NSObject {
	private let resolver: Resolver
	private weak var viewController: UIViewController?
	fileprivate let transitionInteractor = TransitionInteractor()
	
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
	func showProfile() { 
        let parent = viewController?.navigationController?.parent as? DashboardViewController
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            parent?.showProfile()
        }
        self.viewController?.navigationController?.popToRootViewController(animated: true)
        CATransaction.commit()
	}
    
    func showInterfaceTutorial() {
        let viewController = resolver.resolve(InterfaceTutorialViewController.self)!
        viewController.transitioningDelegate = self
        viewController.transitionInteractor = transitionInteractor
        self.viewController?.present(viewController, animated: true, completion: nil)
    }
	
	func showWallet() {
		let viewController = resolver.resolve(WalletViewController.self)!
		let modalViewContoller = ModalViewContoller(with: viewController)
		self.viewController?.present(modalViewContoller, animated: true, completion: nil)
	}
    
    func showDiscount(_ id: Int) {
        let externalUserId = Main.userId
        Main.shared?.reportEventToYandexMetrica(
            message: "MAIN_BANNER",
            YMparams: ["campaign_id": id,
                       "user_id": externalUserId]
        )
        
        let viewController = resolver.resolve(DiscountViewController.self, argument: id)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSupport() {
        Main.shared?.showSupport()
    }
    
    func showSignIn() {
        let viewController = resolver.resolve(LoginViewController.self)!
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.viewController?.present( navigationController, animated: true, completion: nil)
    }
    
    func showMoreDiscounts(_ sectionId: Int) {
        let viewController = resolver.resolve(SectionBannersViewController.self, argument: sectionId)!
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .formSheet
        self.viewController?.present(navigationController, animated: true, completion: nil)
    }
    
    // open from push notification
    func showTicket(_ ticketId: Int) {
        let viewController = resolver.resolve(TicketViewController.self, argument: ticketId)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showNotify() {
        let viewController = resolver.resolve(NotificationsViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showChat() {
        let viewController = resolver.resolve(ChatViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // open from deeplink
    func showProductList(_ campaignId: Int, _ campaingTitle: String) {
        let viewController = resolver.resolve(ProductListViewController.self, arguments: campaignId, campaingTitle)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showProductCard(_ campaignId: Int, _ productId: Int, _ campaingTitle: String) {
        let viewController = resolver.resolve(ProductCardViewController.self, arguments: campaignId, productId, campaingTitle)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }

    func showPersonalInfo() {
        let viewController = resolver.resolve(PersonalInfoViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showCosts(_ categoryId: Int) {
        let viewController = resolver.resolve(CostsViewController.self, argument: categoryId)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showStoreCosts(_ retailer: (Int, String)) {
        let viewController = resolver.resolve(CostsByStoreViewController.self, argument: retailer)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showTickets() {
        let viewController = resolver.resolve(TicketsViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showOrders() {
        let viewController = resolver.resolve(OrdersViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showTicketsOnline() {
        let viewController = resolver.resolve(TicketsOnlineViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showPayments() {
        let viewController = resolver.resolve(PaymentsViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showPaymentOutcome(_ id: Int) {
        let viewController = resolver.resolve(TransactionViewController.self, argument: id)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showPaymentRequest(_ id: Int) {
        let viewController = resolver.resolve(PaymentRequestViewController.self, argument: id)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func inviteFriend() {
        let viewController = resolver.resolve(InviteFriendViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showProfy() {
        let viewController = resolver.resolve(ProfyViewController.self)!
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }

    func showScanQR() {
        let parent = viewController?.navigationController?.parent as? DashboardViewController
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            parent?.showScanner()
        }
        self.viewController?.navigationController?.popToRootViewController(animated: true)
        CATransaction.commit()
    }
    
    func showMainCosts() {
        let parent = viewController?.navigationController?.parent as? DashboardViewController
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            parent?.showCosts()
        }
        self.viewController?.navigationController?.popToRootViewController(animated: true)
        CATransaction.commit()
    }
}

extension MainRouter: UIViewControllerTransitioningDelegate {
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
	 DismissAnimator()
	}
	
	func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		transitionInteractor.hasStarted ? transitionInteractor : nil
	}
}
