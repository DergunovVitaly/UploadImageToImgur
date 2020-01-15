//
//  NetworkManager.swift
//
//
//
//
//

import Foundation
import UIKit
import Reachability
import SCLAlertView

class NetworkReachabilityManager {
    
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
            AlertViewController.showAlertView(title: Localizable.warning(),
                                              subTitle: Localizable.connectToTheInternet(),
                                              style: .error, closeButtonTitle: Localizable.ok())
            debugPrint("Network not reachable")
        }
    }
}
