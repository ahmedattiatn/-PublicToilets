//
//  LocationManager.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Combine
import CoreLocation
import MapKit

// MARK: - MapDetails

private enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 48.86590576171875, longitude: 2.218998820467334)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

// MARK: - LocationManager

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?

    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)

    func checkIfLocationServiceIsEnable() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self

        } else {
            print("Please turn on the location service")
        }
    }

    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted.")
        case .denied:
            print("You have denied this app location permission. Go to setting to change it")
        case .authorizedAlways,
             .authorizedWhenInUse:
            if let userLocation = locationManager.location?.coordinate {
                region = MKCoordinateRegion(center: userLocation, span: MapDetails.defaultSpan)
            }
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    /// get distance in km
    func getDisanceFrom(coordinates: CLLocationCoordinate2D?) -> CLLocationDistance? {
        guard let userCoordinate = locationManager?.location?.coordinate,
              let coordinates = coordinates
        else {
            return nil
        }
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        return userLocation.distance(from: destination) / 1000
    }

    func updateRegionWith(coordinates: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinates, span: MapDetails.defaultSpan)
    }
}
