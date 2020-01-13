//
//  UploadResults.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 13.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation

struct UploadResult: Codable {
  let link: URL

  var debugDescription: String {
    return "<UploadResult: \(link)"
  }
}
