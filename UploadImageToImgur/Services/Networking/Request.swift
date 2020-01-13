//
//  Request.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 13.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import Moya

class Request {
    
    static func uploadImage(image: UIImage, completion: @escaping(Result<URL, Error>) -> Void) {
        let provider = MoyaProvider<Imgur>()
        var uploadResult: UploadResult?
        provider.request(.upload(image), callbackQueue: DispatchQueue.main,
                         //                         progress: {[weak self] progress in
            //                            self?.progressView.setProgress(Float(progress.progress), animated: true)
            //            },
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
