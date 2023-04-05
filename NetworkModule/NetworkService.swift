//
//  NetworkService.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import RxSwift
import Moya

public protocol NetworkService: AnyObject {
  func execute<Target: Moya.TargetType>(_ target: Target) -> Completable
  func execute<Target: Moya.TargetType, Value: Decodable>(_ target: Target, with type: Value.Type) -> Single<Value>
}

