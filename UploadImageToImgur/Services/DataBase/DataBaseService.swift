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
  
    func writeToDataBase(url: String) {
        DispatchQueue.global().async {
            guard let realm = try? Realm() else { return }
            let newItem = UrlDBModel()
            newItem.urlString = url
            try? realm.write {
                realm.add(newItem)
            }
        }
    }
    
    func readFromDataBase() -> [String] {
        guard let realm = try? Realm() else { return [] }
        let urlsArray = realm.objects(UrlDBModel.self).sorted(byKeyPath: "createdAt", ascending: false)
        return urlsArray.map { $0.urlString }
    }
}
