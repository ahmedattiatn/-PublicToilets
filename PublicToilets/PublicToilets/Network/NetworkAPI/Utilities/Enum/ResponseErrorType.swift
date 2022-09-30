//
//  ResponseErrorType.swift
//
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Foundation

// MARK: - ResponseErrorType

public enum ResponseErrorType: Equatable {
    case notAuthorized
    case notFound
    case notRespondingServer
    case generic
}
