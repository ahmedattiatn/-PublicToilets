//
//  TextStyle.swift
//  PublicToilets
//
//  Created by Ahmed ATIA on 29/09/2022.
//

import SwiftUI

// MARK: - TextStyle14Regular

struct TextStyle14Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 14 : 14 * 1.75, weight: .regular))
    }
}

// MARK: - TextStyle14Bold

struct TextStyle14Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 14 : 14 * 1.75, weight: .bold))
    }
}

// MARK: - TextStyle20Bold

struct TextStyle20Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 20 * 1.75, weight: .bold))
    }
}

// MARK: - TextStyle16Bold

struct TextStyle16Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 16 : 16 * 1.75, weight: .bold))
    }
}

// MARK: - TextStyle18Bold

struct TextStyle18Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 18 : 18 * 1.75, weight: .bold))
    }
}

// MARK: - TextStyle16Regular

struct TextStyle16Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 16 : 16 * 1.75, weight: .regular))
    }
}

extension View {
    func textStyle14Regular() -> some View {
        self.modifier(TextStyle14Regular())
    }

    func textStyle20Bold() -> some View {
        self.modifier(TextStyle20Bold())
    }

    func textStyle14Bold() -> some View {
        self.modifier(TextStyle14Bold())
    }

    func textStyle18Bold() -> some View {
        self.modifier(TextStyle18Bold())
    }

    func textStyle16Regular() -> some View {
        self.modifier(TextStyle16Regular())
    }

    func textStyle16Bold() -> some View {
        self.modifier(TextStyle16Bold())
    }
}
