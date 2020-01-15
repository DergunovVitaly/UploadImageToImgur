//
//  DBModel.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 14.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import RealmSwift

class UrlDBModel: Object {
    @objc dynamic var urlString = ""
    @objc dynamic var createdAt = Date()
}
