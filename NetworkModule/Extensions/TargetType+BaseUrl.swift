//
//  TargetType+BaseUrl.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Moya

public extension TargetType {
    var baseURL: URL { fatalError("baseUrl is customised by custom Endpoint for MoyaProvider") }
    var sampleData: Data { Data() }
    var headers: [String: String]? { nil }
    var validationType: ValidationType { .successAndRedirectCodes }
}
