//
//  NetworkProviderBuilder.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Moya

protocol NetworkProviderBuilderType {
    func provider<T: Moya.TargetType>(for type: T.Type) -> Moya.MoyaProvider<T>
    func provider<T: Moya.TargetType>(stubClosure: @escaping Moya.MoyaProvider<T>.StubClosure) -> Moya.MoyaProvider<T>
}

final class NetworkProviderBuilder: NetworkProviderBuilderType {
    private let baseUrl: String
    private let forTest: Bool
    private let queue: DispatchQueue
    private let lock = NSLock()
    private var plugins: [Moya.PluginType]
    private var providers: [Swift.ObjectIdentifier: AnyObject] = [:]

    init(baseUrl: String, forTest: Bool, queue: DispatchQueue, plugins: [Moya.PluginType] = []) {
        self.baseUrl = baseUrl
        self.forTest = forTest
        self.queue = queue
        self.plugins = plugins
    }

    func provider<T: Moya.TargetType>(for type: T.Type) -> Moya.MoyaProvider<T> {
        return provider(stubClosure: defaultStub)
    }

    func provider<T: Moya.TargetType>(stubClosure: @escaping Moya.MoyaProvider<T>.StubClosure) -> Moya.MoyaProvider<T> {
        let identifier = Swift.ObjectIdentifier(T.self)

        return lock.sync {
            if let provider = providers[identifier] as? Moya.MoyaProvider<T> { return provider }

            let provider = Moya.MoyaProvider<T>(endpointClosure: endpoint, stubClosure: stubClosure, callbackQueue: queue, plugins: plugins)

            providers[identifier] = provider

            return provider
        }
    }

    private func defaultStub<T: TargetType>(_ target: T) -> Moya.StubBehavior {
        guard !forTest else { return .immediate }
        guard let target = target as? TargetTypeStubSupportable else { return .never }

        return target.stubBehavior
    }
}

// MARK: - Privates
private extension NetworkProviderBuilder {
    func endpoint<T: TargetType>(_ target: T) -> Moya.Endpoint {
        return Endpoint(url: baseUrl.appending(target.path),
                                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                        method: target.method,
                                        task: target.task,
                                        httpHeaderFields: target.headers)
    }
}

private extension NSLocking {
  func sync<T>(_ closure: () -> T) -> T {
    lock()
    defer { unlock() }

    return closure()
  }
}

