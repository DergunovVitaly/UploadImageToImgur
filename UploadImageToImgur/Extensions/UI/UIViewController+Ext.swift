//
//  UIViewController+Ext.swift
//  
//
//  Created by Vitalii Derhunov on 25.10.2019.
//  
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func presentErrorAlert() {
        let alert = UIAlertController(title: Localizable.error(),
                                      message: Localizable.wentWrong(),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.cancel(), style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}
