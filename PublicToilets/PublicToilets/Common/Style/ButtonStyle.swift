//
//  ButtonStyle.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 30/09/2022.
//

import SwiftUI

// MARK: - ButtonStyleFilled

struct ButtonStyleFilled: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minHeight: Dimension.buttonHeight)
            .textStyle16Bold()
            .padding(.horizontal, Dimension.padding8)
            .background(.orange)
            .cornerRadius(Dimension.cornerRadius)
            .foregroundColor(.white)
    }
}

// MARK: - ButtonStyleEmpty

struct ButtonStyleEmpty: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minHeight: Dimension.buttonHeight)
            .textStyle16Bold()
            .background(Color.white.opacity(0))
    }
}

// MARK: - ButtonStyleFloated

struct ButtonStyleFloated: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: Dimension.buttonHeight, minHeight: Dimension.buttonHeight)
            .foregroundColor(.white)
            .background(Color.orange)
            .cornerRadius(Dimension.cornerRadius)
            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 4, y: 4)
    }
}
