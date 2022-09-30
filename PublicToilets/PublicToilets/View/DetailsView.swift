//
//  DetailsView.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//

import MapKit
import SwiftUI

// MARK: - DetailsView

struct DetailsView: View {
    var publicToiletInfos: Fields
    @State var displayAnimation: Bool = true

    var body: some View {
        BaseView(title: "Public Toilets Details") {
            VStack(alignment: .center, spacing: Dimension.padding8) {
                LottieView(name: "animationView", loopMode: .loop, play: $displayAnimation)
                    .scaledToFit()
                Text(publicToiletInfos.adresse ?? "")
                    .textStyle16Bold()
                if let arr = publicToiletInfos.arrondissement {
                    Text("\(arr)")
                        .textStyle16Regular()
                }
                if let horaire = publicToiletInfos.horaire {
                    HoraireView(horaire: horaire, urlFicheEquipement: publicToiletInfos.urlFicheEquipement)
                }
                Text(publicToiletInfos.gestionnaire?.rawValue ?? "")
                    .textStyle16Regular()
                Text(publicToiletInfos.type?.rawValue ?? "")
                    .textStyle16Regular()
            }
        }
        .onAppear { self.displayAnimation = true }
        .onDisappear { self.displayAnimation = false }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
