//
//  HandicapView.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 30/09/2022.
//

import SwiftUI

struct HandicapView: View {
    var body: some View {
        Image("handicape")
            .resizable()
            .scaledToFit()
            .frame(width: Dimension.imageSize, height: Dimension.imageSize, alignment: .leading)
    }
}
