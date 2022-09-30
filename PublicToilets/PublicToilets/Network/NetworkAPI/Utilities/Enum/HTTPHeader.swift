//
//  HTTPHeader.swift
//
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Foundation

// MARK: - HTTPHeader

public enum HTTPHeader: String {
    case applicationJson = "application/json"
    case contentType = "Content-Type"
    case accept = "Accept"

    var value: String { return rawValue }
}

// MARK: - HTTPMethod

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
