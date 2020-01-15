//
//  AlertViewController.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 15.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import SCLAlertView

class AlertViewController {
    
    static func showAlertView(title: String, subTitle: String, style: SCLAlertViewStyle, closeButtonTitle: String) {
        let alertView = SCLAlertView()
        alertView.showTitle(title,
                            subTitle: subTitle,
                            style: style,
                            closeButtonTitle: closeButtonTitle,
                            colorStyle: 0x4A90E2,
                            colorTextButton: 0x000000,
                            animationStyle: .noAnimation)
    }
}
