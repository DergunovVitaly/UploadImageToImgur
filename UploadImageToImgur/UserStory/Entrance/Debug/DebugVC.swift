//
//  DebugVC.swift
//  HomeNotes
//
//  Created by Simon Kostenko on 8/13/19.
//  Copyright © 2019 ANODA. All rights reserved.
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
    }
}
