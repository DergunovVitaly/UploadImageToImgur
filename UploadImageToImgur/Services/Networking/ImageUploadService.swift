//
//  ImageUploadService.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 13.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import Moya

class ImageUploadService {
 
    private static let serialQueue = DispatchQueue(label: "com.imgur")
    private static let semaphore = DispatchSemaphore(value: 1)
  
    static func uploadImageModel(image: ImageModel, completion: @escaping(Result<URL, Error>) -> Void) {
        let provider = MoyaProvider<Imgur>()

        serialQueue.async {
            semaphore.wait()
            provider.request(.upload(image.image), callbackQueue: DispatchQueue.main) { response in
                switch response {
                case .success(let result):
                    do {
                        let upload = try result.map(ImgurResponse<UploadResult>.self)
                        completion(.success(upload.data.link))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
                semaphore.signal()
            }
        }
    }
}
