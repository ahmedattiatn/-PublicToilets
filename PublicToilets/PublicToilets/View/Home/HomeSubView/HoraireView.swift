//
//  HoraireView.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 30/09/2022.
//

import SwiftUI

// MARK: - HoraireView

struct HoraireView: View {
    @Environment(\.openURL) private var openURL

    let horaire: Horaire
    let urlFicheEquipement: String?
    var body: some View {
        Button(action: { openUrlIfNeeded(horaire: horaire) }) {
            Text(horaire.rawValue)
                .textStyle14Regular()
                .foregroundColor(horaire == .voirFicheÉquipement ? .blue : .black)
        }
        .buttonStyle(ButtonStyleEmpty())
    }

    private func openUrlIfNeeded(horaire: Horaire) {
        if horaire == .voirFicheÉquipement,
           let stringUrl = urlFicheEquipement,
           let url = URL(string: stringUrl)
        {
            openURL(url)
        }
    }
}
