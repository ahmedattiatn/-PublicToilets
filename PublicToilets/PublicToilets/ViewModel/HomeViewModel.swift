//
//  HomeViewModel.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Combine
import CoreLocation
import Foundation
import SwiftUI

// MARK: - HomeViewModel

class HomeViewModel: ObservableObject {
    public static var shared = HomeViewModel()
    @StateObject private var locationManager = LocationManager()

    @Published var publicToilets: [PublicToilet] = []
    private var toilets: [PublicToilet] = []
    private var subscriptions = Set<AnyCancellable>()
    private let baseEndpoint = AppInfo.shared.apiBaseUrl

    private init() {
        getRemoteToilets()
    }

    func getRemoteToilets() {
        let request: URLRequest? = NetworkAPI.shared.createRequest(for: baseEndpoint, with: .get)
        NetworkAPI.shared.dataTaskPublisher(for: request, retryTimes: 2)
            .decode(type: Toilet.self, decoder: JSONDecoder(), errorTransform: { NetworkAPIError($0) })
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                      if case let .failure(error) = completion {
                          print("*******  Failed with \(error.localizedDescription)  *******")
                      }
                  },
                  receiveValue: { self.createPublicToilets(from: $0.records) })
            .store(in: &subscriptions)
    }

    private func createPublicToilets(from records: [Record]) {
        for record in records {
            let coordinate = CLLocationCoordinate2D(latitude: record.fields.geoPoint2D[0], longitude: record.fields.geoPoint2D[1])
            publicToilets.append(PublicToilet(record: record, coordinate: coordinate))
        }
        toilets = publicToilets
    }

    func show(onlyAccesPmrPublicToilet: Bool) {
        publicToilets = onlyAccesPmrPublicToilet ? publicToilets.filter { $0.record.fields.accesPmr == .oui } : toilets
    }

    deinit {
        self.subscriptions.removeAll()
    }
}
