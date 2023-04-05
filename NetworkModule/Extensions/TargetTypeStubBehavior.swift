//
//  TargetTypeStubBehavior.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Moya

protocol TargetTypeStubSupportable {
  var stubBehavior: StubBehavior { get }
}
