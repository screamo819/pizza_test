//
//  Main.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 04.04.2023.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

final class Main: NSObject {
    private let disposeBag = DisposeBag()
    private let mainAssembler: Main.Assembler

    let router: Main.Router

    init(_ window: UIWindow) {
        self.mainAssembler = .init()
        self.router = .init(window, mainAssembler)
        super.init()
    }
}

extension Main {
    class var shared: Main? {
        (UIApplication.shared.delegate as? AppDelegate)?.main
    }
}
