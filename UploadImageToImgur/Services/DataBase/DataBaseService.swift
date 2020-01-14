//
//  DataBaseService.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 14.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseService {
    static func addURLsToDataBase(url: String) {
        DispatchQueue.global().async {
            guard let realm = try? Realm() else { return }
            let newItem = UrlDBModel()
            newItem.urlString = url
            try? realm.write {
                realm.add(newItem)
            }
        }
    }
}
