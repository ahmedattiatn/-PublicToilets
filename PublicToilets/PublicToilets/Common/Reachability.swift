//
//  Reachability.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Network
import SwiftUI

// MARK: - Reachability

class Reachability: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Reachability")

    @Published var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {
                return
            }
            // Monitor runs on a background thread so we need to publish
            // on the main thread
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }

    public func cancelMonitor() {
        monitor.cancel()
    }
}
