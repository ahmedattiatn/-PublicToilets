//
//  BannerView.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//

import SwiftUI

// MARK: - BannerView

struct BannerView: View {
    let showView: Bool
    let text: String
    let image: String
    @State var isTopBanner: Bool = false
    var color = Color.red
    var body: some View {
        if showView {
            HStack(spacing: Dimension.paddingErrorView) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Dimension.imageSize, height: Dimension.imageSize)
                    .padding(.top, isTopBanner ? Dimension.paddingStatusBar : 0)
                Text(text)
                    .textStyle14Regular()
                    .foregroundColor(.white)
                    .padding(.top, isTopBanner ? Dimension.paddingStatusBar : 0)
                Spacer()
            }
            .padding(Dimension.paddingErrorView)
            .background(Rectangle().fill(color))
        }
    }
}

// MARK: - BannerView_Previews

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(showView: true, text: "Hello", image: "ic-bluetooth-disabled", isTopBanner: true)
    }
}
