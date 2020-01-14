//
//  NetworkManager.swift
//  Scape
//
//  Created by Alexandr Velikotckiy on 10/3/19.
//  Copyright © 2019 Glance. All rights reserved.
//

import Foundation
import UIKit
import Reachability

protocol NetworkReachabilityManagerDelegate: class {
    func reachabilityChanged(connection: Reachability.Connection)
}

class NetworkReachabilityManager {
    
    weak var delegate: NetworkReachabilityManagerDelegate?
    
    let reachability: Reachability?
    static var shared = NetworkReachabilityManager()
    
    private init() {
        self.reachability = try? Reachability()
    }

    deinit {
        stopReachability()
    }
    
    func beginReachability() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged),
                                               name: .reachabilityChanged,
                                               object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            debugPrint("could not start reachability notifier")
        }
    }
        
    func stopReachability() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func rebootReachability() {
        stopReachability()
        beginReachability()
    }
    
    @objc func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? Reachability
            else { rebootReachability(); return }
        
        switch reachability.connection {
        case .wifi:
            debugPrint("Reachable via WiFi")
        case .cellular:
            debugPrint("Reachable via Cellular")
        case .none, .unavailable:
            debugPrint("Network not reachable")
        }
        delegate?.reachabilityChanged(connection: reachability.connection)
    }
}
