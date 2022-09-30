//
//  HomeListRowView.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//

import SwiftUI

// MARK: - HomeListRowView

struct HomeListRowView: View {
    @State private var showDetailsView: Bool = false

    var publicToiletInfos: Fields
    var distance: Double?

    var body: some View {
        ZStack(alignment: .leading) {
            NavigationLink(destination: DetailsView(publicToiletInfos: publicToiletInfos), isActive: $showDetailsView) {
                EmptyView()
            }
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())
            VStack(alignment: .leading, spacing: Dimension.padding8) {
                Text(publicToiletInfos.adresse ?? "")
                    .textStyle16Bold()
                HStack(alignment: .center, spacing: Dimension.padding8) {
                    if publicToiletInfos.accesPmr == .oui {
                        HandicapView()
                    }
                    if let horaire = publicToiletInfos.horaire {
                        HoraireView(horaire: horaire, urlFicheEquipement: publicToiletInfos.urlFicheEquipement)
                    }
                    Spacer()
                    Button {
                        showDetailsView = true
                    } label: {
                        Text("Details")
                    }
                    .buttonStyle(ButtonStyleFilled())
                }
                if let distance = distance {
                    Text("\(String(format: "%.2f", distance)) km")
                        .textStyle16Regular()
                }
            }
        }
        .background(Color.white)
        .frame(maxWidth: .infinity, minHeight: Dimension.listRowHeight, alignment: .leading)
    }
}
