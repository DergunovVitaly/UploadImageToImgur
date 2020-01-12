//
//  NetworkService.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 12.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import Moya

public enum Imgur {
    
  static private let clientId = "ae60b8e7c7c23dc"
  case upload(UIImage)
}

extension Imgur: TargetType {
  
  public var baseURL: URL {
    return URL(string: "https://api.imgur.com/3")!
  }

  public var path: String {
    switch self {
    case .upload: return "/image"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .upload: return .post
    }
  }

  public var sampleData: Data {
    return Data()
  }

  public var task: Task {
    switch self {
    case .upload(let image):
      let imageData = image.jpegData(compressionQuality: 1.0)!

      return .uploadMultipart([MultipartFormData(provider: .data(imageData),
                                                 name: "image",
                                                 fileName: "photoFromLibrary.jpg",
                                                 mimeType: "image/jpg")])
    }
  }

  public var headers: [String: String]? {
    return [
      "Authorization": "Client-ID \(Imgur.clientId)",
      "Content-Type": "application/json"
    ]
  }

  public var validationType: ValidationType {
    return .successCodes
  }
}
