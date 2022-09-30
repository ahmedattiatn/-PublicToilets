//
//  Dimension.swift
//  PublicToilets
//
//  Created by Ahmed ATIA on 20/09/2021.
//

import SwiftUI

// MARK: - Dimension

struct Dimension {
    static let padding16: CGFloat = 16.0
    static let padding8: CGFloat = 8.0
    static let cornerRadius: CGFloat = 20.0
    static let imageSize: CGFloat = 24
    static let listRowHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 80 : 80 * 1.75
    static let paddingErrorView: CGFloat = 8
    static let paddingStatusBar: CGFloat = 35
    static let buttonHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 48 : 48 * 1.75
}
