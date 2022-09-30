//
//  HomeView.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//
import MapKit
import SwiftUI

// MARK: - HomeView

struct HomeView: View {
    @ObservedObject private var homeViewModel = HomeViewModel.shared
    @StateObject private var locationManager = LocationManager()
    @State private var annotations: [PublicToilet] = []
    @State private var showOnlyAccesPmrPublicToilet = false
    @State var showSheet = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                BaseView(title: "Public Toilets", showBackButtonItem: false) {
                    Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: annotations) {
                        MapPin(coordinate: $0.coordinate)
                    }
                    .accentColor(Color(.systemPink))
                    List {
                        ForEach(homeViewModel.publicToilets, id: \.id) { publicToilet in
                            HomeListRowView(publicToiletInfos: publicToilet.record.fields,
                                            distance: locationManager.getDisanceFrom(coordinates: publicToilet.coordinate))
                                .onTapGesture {
                                    locationManager.updateRegionWith(coordinates: publicToilet.coordinate)
                                }
                        }
                    }
                    .listStyle(.plain)
                    .refreshable { homeViewModel.getRemoteToilets() }
                    .background(
                        LottieView(name: "animationView", loopMode: .loop, play: .constant(true))
                            .scaledToFit()
                    )
                }
                Button(action: {
                    withAnimation {
                        showOnlyAccesPmrPublicToilet.toggle()
                        homeViewModel.show(onlyAccesPmrPublicToilet: showOnlyAccesPmrPublicToilet)
                    }

                }) {
                    HandicapView()
                }
                .buttonStyle(ButtonStyleFloated())
                .padding(Dimension.padding16)
            }
            .onAppear { locationManager.checkIfLocationServiceIsEnable() }
            .onReceive(homeViewModel.$publicToilets) { self.annotations = $0 }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - HomeView_Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
