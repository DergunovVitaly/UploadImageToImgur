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
    
    static func uploadImageModel(image: ImageModel, completion: @escaping(Result<URL, Error>) -> Void) {
        let provider = MoyaProvider<Imgur>()
        var uploadResult: UploadResult?
        provider.request(.upload(image.image), callbackQueue: DispatchQueue.main,
            completion: { response in
                switch response {
                case .success(let result):
                    do {
                        let upload = try result.map(ImgurResponse<UploadResult>.self)
                        uploadResult = upload.data
                        completion(.success(upload.data.link))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        })
    }
}
