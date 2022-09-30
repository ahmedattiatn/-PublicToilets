//
//  AppInfo.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 30/09/2022.
//

import Foundation

// MARK: - AppInfo

struct AppInfo {
    static var shared = AppInfo()
    // lets hold a reference to the Info.plist of the app as Dictionary
    private let infoPlistDictionary = Bundle.main.infoDictionary

    private init() {}

    var apiBaseUrl: String {
        return readFromInfoPlist(withKey: "ApiBaseUrl") ?? "[Required] Info.plist/Targets User Defined malformed for UF: ApiBaseUrl"
    }
}

extension AppInfo {
    /// Retrieves and returns associated values (of Type String) from info.Plist of the app.
    private func readFromInfoPlist(withKey key: String) -> String? {
        return infoPlistDictionary?[key] as? String
    }

    /// Retrieves and returns associated values (of Type String) from info.Plist of the app.
    private func readDictFromInfoPlist(withKey key: String) -> NSDictionary? {
        return infoPlistDictionary?[key] as? NSDictionary
    }
}
