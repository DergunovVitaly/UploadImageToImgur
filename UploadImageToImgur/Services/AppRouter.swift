//
//  AppRouter.swift
//  HomeNotes
//
//  Created by Vitalii Derhunov on 20.08.2019.
//  
//

import Foundation
import UIKit

enum NavigationState {
    case main
    case debug
}

final class AppRouter {
    
    static func newState(_ state: NavigationState, completion: VoidClosure? = nil) {
        
        let window = UIApplication.shared.keyWindow
        
        switch state {
        case.main:
            window?.rootViewController = UINavigationController(rootViewController: PhotoGridViewController())
        case .debug:
            window?.rootViewController = UINavigationController(rootViewController: DebugVC())
        }
    }
}
