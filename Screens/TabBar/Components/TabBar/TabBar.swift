//
//  TabBar.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import UIKit
import RxCocoa
import RxSwift

private let selectedColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
private let defaultColor = UIColor(red: 0.592, green: 0.584, blue: 0.573, alpha: 1)

final class TabBar: UIView {
    @IBOutlet fileprivate var itemsView: UIStackView!
    
    var selectedIndex: Int = -1 {
        didSet {
            for (index, item) in itemsView.subviews.compactMap({ $0 as? TabBarItem }).enumerated() {
                item.isSelected = index == selectedIndex
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ items: [TabBarItemModel]) {
        itemsView.subviews.forEach({ $0.removeFromSuperview() })
        
        for (index, item) in items.enumerated() {
            let control: TabBarItem
            if !(item.title ?? "").isEmpty {
                control = R.nib.dashboardTabBarItem.firstView(owner: nil)!
            } else {
                control = R.nib.dashboardTabBarItem.secondView(owner: nil)!
            }
            control.tag = index
            control.selectedColor = selectedColor
            control.defaultColor = defaultColor
            control.setup(item)
            itemsView.addArrangedSubview(control)
        }
    }
}

extension Reactive where Base == DashboardTabBar {
    func controlEvent(_ controlEvents: UIControl.Event) -> Observable<Int> {
        let events = base.itemsView.subviews
            .compactMap({ view in
                (view as? DashboardTabBarItem)?.rx
                    .controlEvent(controlEvents)
                    .map({ _ in
                        view.tag
                    })
                    .asObservable()
            })
        return Observable.merge(events)
    }
}
