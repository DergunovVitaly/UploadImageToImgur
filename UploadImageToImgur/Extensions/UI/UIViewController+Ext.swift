//
//  UIViewController+Ext.swift
//  HomeNotes
//
//  Created by Vitalii Derhunov on 25.10.2019.
//  
//

import UIKit

extension UIViewController {
    var isModal: Bool {
        if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }

    func close(animated: Bool = true) {
        guard isModal else {
            navigationController?.popViewController(animated: animated)
            return
        }
        dismiss(animated: animated)
    }
}

extension UITraitEnvironment {
    func handleUserStyleChange(from fromTraits: UITraitCollection?,
                               toTraits: UITraitCollection,
                               handler: (() -> Void)) {
        guard #available(iOS 12.0, *) else { return }
        guard let previousTraitCollection = fromTraits else { return }
        guard toTraits.userInterfaceStyle != previousTraitCollection.userInterfaceStyle else { return }
        handler()
    }
}
