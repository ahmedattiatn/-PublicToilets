//
//  PublicToilet.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Foundation
import MapKit

// MARK: - CLLocationCoordinate2D + Identifiable

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

// MARK: - PublicToilet

struct PublicToilet: Identifiable {
    let id = UUID()
    let record: Record
    let coordinate: CLLocationCoordinate2D
}
