//
//  VendorService.swift
//  
//
//  Created by Vitalii Derhunov on 21.08.2019.
//  
//

import UIKit

class VendorService: NSObject {
    
    static func start(options: [UIApplication.LaunchOptionsKey: Any]?) {
        NetworkReachabilityManager.shared.beginReachability()
    }
}
