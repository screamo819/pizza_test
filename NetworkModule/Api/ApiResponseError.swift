//
//  ApiResponseError.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation

public struct ApiErrorResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case status, error
    }

    public let status: String
    public let error: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        status = (try? container.decode(String.self, forKey: .status)) ?? ""
        error = (try? container.decode(String.self, forKey: .error)) ?? ""
    }
}
