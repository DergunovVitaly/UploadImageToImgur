//
//  PhotoLibrariViewModel.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 11.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import UIKit
import Photos

class PhotoGridViewModel {
    
    func grabPhotos(completion: @escaping  (Result<[ImageModel], Error>) -> Void) {
        var imageArray = [ImageModel]()
       
        let imgManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if fetchResult.count > 0 {
            for item in 0..<fetchResult.count {
                let asset = fetchResult.object(at: item)
                imgManager.requestImage(for: asset,
                                        targetSize: CGSize(width: 210,
                                                           height: 210),
                                        contentMode: .aspectFit,
                                        options: requestOptions) { (image, error) in
                                            guard let image = image else { return }
                                            imageArray.append(ImageModel(image: image, id: asset.localIdentifier))
                                            debugPrint(error ?? "")
                }
            }
            completion(.success(imageArray))
        } else {
            debugPrint(Localizable.noPhoto())
        }
    }
}
