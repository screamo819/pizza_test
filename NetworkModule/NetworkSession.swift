//
//  NetworkSession.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 05.04.2023.
//

import Alamofire
import Moya
import RxSwift

final class NetworkSession {
    private let providerBuilder: NetworkProviderBuilderType
    private let jsonDecoder: JSONDecoder

    init(providerBuilder: NetworkProviderBuilderType, jsonDecoder: JSONDecoder) {
        self.providerBuilder = providerBuilder
        self.jsonDecoder = jsonDecoder
    }
}

// MARK: - NetworkService
extension NetworkSession: NetworkService {
    func execute<Target: Moya.TargetType>(_ target: Target) -> Completable {
        providerBuilder.provider(for: Target.self).rx.request(target)
            .catchError(handleError)
            .asCompletable()
    }

    func execute<Target: Moya.TargetType, Value: Decodable>(_ target: Target, with value: Value.Type = Value.self) -> Single<Value> {
        providerBuilder.provider(for: Target.self).rx.request(target)
            .map(Value.self, using: jsonDecoder)
            .catchError(handleError)
    }
}

// MARK: - Privates
private extension NetworkSession {

    func handleError<T>(_ error: Swift.Error) -> Single<T> {
        guard let error = error as? MoyaError else { return .error(NetworkSessionError.unknown) }

        switch error {
        case .underlying(let error, let response):
            if (error as? AFError)?.underlyingError?.isNetworkConnectionError == true {
                return .error(NetworkSessionError.connection)
            }

            if let response = response {
                return .error(handleFailureResponse(response, error: error))
            }

            return .error(NetworkSessionError.custom(context: .init(statusCode: nil, underlayingError: error, apiError: nil)))
        case .objectMapping(let error, let response):
            return .error(NetworkSessionError.decoding(context: .init(statusCode: response.statusCode, underlayingError: error, apiError: nil)))
        default:
                return .error(NetworkSessionError.unknown)
        }
    }

    func handleFailureResponse(_ response: Response, error: Error) -> NetworkSessionError {
        switch response.statusCode {
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        default:
            do {
                let decodedResponse = try JSONDecoder.iso8601compatible.decode(ApiErrorResponse.self, from: response.data)
                return .custom(
                    context: NetworkSessionError.Context(
                        statusCode: response.statusCode,
                        underlayingError: error,
                        apiError: decodedResponse
                    )
                )
            } catch _ {
                return .custom(
                    context: NetworkSessionError.Context(
                        statusCode: response.statusCode,
                        underlayingError: error,
                        apiError: nil
                    )
                )
            }
        }
    }

    func unwrapError(_ error: Error) -> Error {
        if let error = (error as? MoyaError), case MoyaError.underlying(let unwrappedError, nil) = error {
            return unwrappedError
        } else if let error = (error as? Alamofire.AFError)?.underlyingError {
            return error
        }

        return error
    }
}

public enum NetworkSessionError: Error {
    public struct Context {
        public let statusCode: Int?
        public let underlayingError: Error?
        public let apiError: ApiErrorResponse?
    }

    case connection
    case objectMapping
    case unauthorized
    case forbidden
    case decoding(context: Context)
    case custom(context: Context)
    case unknown

    public var isNetworkSessionExpired: Bool {
        switch self {
        case .unauthorized, .forbidden:
            return true
        default:
            return false
        }
    }

    public var isNetworkConnectionError: Bool {
        guard case .connection = self else { return false }

        return true
    }
}
