//
//  NetworkAssembly.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Foundation
import Moya
import Swinject

public final class NetworkAssembly: Assembly {

    public init() { }

    public func assemble(container: Container) {
        container.register(NetworkService.self) { (resolver, forTests: Bool, baseUrl: String) in
            let providerBuilder = resolver.resolve(NetworkProviderBuilderType.self, arguments: forTests, baseUrl)!
            let jsonDecoder = JSONDecoder.iso8601compatible

            return NetworkSession(
                providerBuilder: providerBuilder,
                jsonDecoder: jsonDecoder
            )
        }
        .inObjectScope(.transient)

        container.register(NetworkProviderBuilderType.self) { (resolver, forTests: Bool, baseUrl: String) in
           
            let loggerPlugin = NetworkLoggerPlugin()
            
            let plugins: [Moya.PluginType] = [
                    loggerPlugin
            ]

            return NetworkProviderBuilder(baseUrl: baseUrl, forTest: forTests, queue: .global(qos: .default), plugins: plugins)
        }
        .inObjectScope(.transient)
    }

    private static func JSONResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? "## Cannot map data to String ##"
        }
    }
}
