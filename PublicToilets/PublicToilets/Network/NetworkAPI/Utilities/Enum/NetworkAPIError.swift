//
//  NetworkAPIError.swift
//
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Foundation

// MARK: - NetworkAPIError

public enum NetworkAPIError: Error, LocalizedError {
    case urlError(URLError)
    case responseError(ResponseError)
    case decodingError(DecodingError)
    case genericError

    public var localizedDescription: String {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
        case .decodingError(let error):
            return error.localizedDescription
        case .responseError(let responseError):
            return "Bad response code: \(responseError.statusCode) for the URL : \n \(responseError.endpoint)  \n\n"
        case .genericError:
            return "An unknown error has been occured"
        }
    }

    /// If the Error is ResponseError return the instance, otherwise return nil
    public var responseError: ResponseError? {
        switch self {
        case .responseError(let responseError): return responseError
        default:
            print("*******  The NetworkAPIError raw is not of type responseError : \(localizedDescription)  *******")
            return nil
        }
    }

    /// Optional Value : because it could be genericError, decodingError, urlError
    public var responseErrorType: ResponseErrorType? {
        guard let responseError = responseError else {
            return nil
        }
        switch responseError.statusCode {
        case 404: return .notFound
        case 500: return .notRespondingServer
        case 401: return .notAuthorized
        default:
            print("*******  Not handled ResponseErrorType : \(localizedDescription)  *******")
            return .generic
        }
    }
}

public extension NetworkAPIError {
    init(_ error: Error) {
        switch error {
        case let urlError as URLError: self = .urlError(urlError)
        case let decodingError as DecodingError: self = .decodingError(decodingError)
        case let networkAPIError as NetworkAPIError: self = networkAPIError
        default: self = .genericError
        }
    }
}
