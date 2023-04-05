//
//  Api.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import Moya

public enum Api: TargetType {
    case getPizza
    
    public var path: String {
        switch self {
        case .getPizza:
            return "json/v1/1/filter.php?c=Cocktail"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getPizza:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getPizza:
            return .requestPlain
        }
    }
}

public extension Api {
    class Parameters { }
    class Response { }
}

