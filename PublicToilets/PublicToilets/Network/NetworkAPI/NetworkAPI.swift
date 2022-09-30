//
//  NetworkAPI.swift
//
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Combine
import Foundation

// MARK: - NetworkAPI

public class NetworkAPI {
    public static var shared = NetworkAPI()
    private let session = URLSession.shared

    private init() {}

    /// This function returns a NetworkAPIError or a Decodable for a given `request` and `memberType`.
    ///
    ///
    /// - Warning: The returned content is not Data.
    /// - Warning: In order to handle Empty Reply use our model `EmptyReply` as a `memberType`.
    /// - Warning: Retry only when the Error is type of NetworkAPIError.responseError.
    /// - Parameter memberType: The memberType is Decodable.self.
    /// - Returns: NetworkAPIError or a Decodable to the `memberType`.
    public func dataTaskPublisher<T: Decodable>(for request: URLRequest?, memberType: T.Type, retryTimes: Int) -> AnyPublisher<T, NetworkAPIError> {
        return self.dataTaskPublisher(for: request, retryTimes: retryTimes)
            .decode(type: T.self, decoder: JSONDecoder(), errorTransform: { NetworkAPIError($0) })
            // There is no need to retry again in case the data decoding fails.
            .eraseToAnyPublisher()
    }

    /// This function returns a NetworkAPIError or a Data for a given `request`.
    ///
    ///
    /// - Warning: Retry only when the Error is type of NetworkAPIError.responseError.
    /// - Returns: NetworkAPIError or a Data.
    public func dataTaskPublisher(for request: URLRequest?, retryTimes: Int) -> AnyPublisher<Data, NetworkAPIError> {
        guard let request = request else {
            print("*******  Invalid Request  *******")
            return Result.Publisher(NetworkAPIError.urlError(URLError(URLError.unsupportedURL)))
                .eraseToAnyPublisher()
        }
        return self.session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200 ... 299 ~= httpResponse.statusCode else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
                    let url: String = request.url?.absoluteString ?? "Can't generate URL from URLRequest"
                    throw NetworkAPIError.responseError(ResponseError(statusCode: statusCode, endpoint: url))
                }
                return data
            }
            .receive(on: RunLoop.main)
            .mapError { NetworkAPIError($0) }
            .retry(times: retryTimes) { self.retryIfNeeded(error: $0) }
            .eraseToAnyPublisher()
    }

    private func retryIfNeeded(error: NetworkAPIError) -> Bool {
        switch error {
        case .responseError:
            print("*******  Retry The Network Call  *******")
            return true
        default:
            print("*******  Skipping the Retry : The NetworkAPIError raw is not of type responseError  *******")
            return false
        }
    }
}

public extension NetworkAPI {
    /// This function returns a URLRequest? for a given `endpoint`.
    func createRequest(for endpoint: String, with httpMethod: HTTPMethod, data: Data? = nil) -> URLRequest? {
        guard let url = URL(string: endpoint) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue(HTTPHeader.applicationJson.value,
                         forHTTPHeaderField: HTTPHeader.contentType.value) // the request is JSON
        request.setValue(HTTPHeader.applicationJson.value,
                         forHTTPHeaderField: HTTPHeader.accept.value) // the response expected to be in JSON
        if let data = data {
            request.httpBody = data
        }
        return request
    }
}
