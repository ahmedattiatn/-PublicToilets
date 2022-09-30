//
//  PublicToiletsApp.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 23/09/2022.
//

import SwiftUI

@main
struct PublicToiletsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
        }
    }
}
