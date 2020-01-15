//
//  Constants.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 11.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import UIKit

typealias Localizable = R.string.localizable
typealias Images = R.image

struct ImgurResponse<T: Codable>: Codable {
  let data: T
}
