//
//  DebugVC.swift
//  HomeNotes
//
//  Created by  Vitaly Dergunov on 11.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import UIKit
import Eureka

class DebugVC: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DebugVC"
        
        // swiftlint:disable all
        form +++ Section()
            <<< LabelRow() { row in
                row.title = "App State - Main"
            }.onCellSelection({ (_, _) in
                AppRouter.newState(.main)
            })
            
            <<< LabelRow() { row in
                row.title = "Photo Grid"
            }.onCellSelection({ (_, _) in
                self.navigationController?.pushViewController(PhotoGridViewController(), animated: true)
            })
    }
}
