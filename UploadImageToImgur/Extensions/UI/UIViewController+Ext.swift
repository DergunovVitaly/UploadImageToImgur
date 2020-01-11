//
//  UIViewController+Ext.swift
//  HomeNotes
//
//  Created by Vitalii Derhunov on 25.10.2019.
//  
//

import UIKit
import MBProgressHUD

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
    
     func showAlert(alertText: String, alertMessage: String, buttonTitle: String) {
        let alert = UIAlertController(title: alertText,
                                      message: alertMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showProgress() {
        DispatchQueue.main.async {
            MBProgressHUD.showProgress(on: self)
        }
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            MBProgressHUD.hideProgress(for: self)
        }
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
