//
//  BaseView.swift
//  PublicToilets
//
//  Created by Ahmed ATIA on 29/09/2022.
//

import SwiftUI

// MARK: - BaseView

struct BaseView<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentation
    @State private var isConnected: Bool = true
    @StateObject var reachability = Reachability()

    private let showBackButtonItem: Bool
    private let content: Content
    private let title: String
    private let noInternetText = "No internet connection"
    private let noInternetImage = "no_internet"

    public init(title: String = "",
                showBackButtonItem: Bool = true,
                backButtonAction: (() -> ())? = nil,
                @ViewBuilder content: () -> Content)
    {
        self.content = content()
        self.title = title
        self.showBackButtonItem = showBackButtonItem
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            BannerView(showView: !isConnected, text: noInternetText, image: noInternetImage)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(self.title)
                    .textStyle18Bold()
                    .foregroundColor(Color.black)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                if self.showBackButtonItem {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 40))
                            .accentColor(.black)
                    }
                }
            }
        }
        .onReceive(reachability.$isConnected, perform: { isConnectedR in
            if isConnectedR != self.isConnected {
                self.isConnected.toggle()
            }
        })
    }
}
