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
    
    func grabPhotos() -> [UIImage] {
        var imageArray = [UIImage]()
        let imgManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        //TODO: Show progress indicator
        if fetchResult.count > 0 {
            for item in 0..<fetchResult.count {
                imgManager.requestImage(for: fetchResult.object(at: item),
                                        targetSize: CGSize(width: 210,
                                                           height: 210),
                                        contentMode: .aspectFit,
                                        options: requestOptions) { (image, error) in
                                            guard let image = image else { return }
                                            imageArray.append(image)
                                            debugPrint(error ?? "")
                }
            }
        } else {
            
            //TODO: Show photos when allow to use photoLibrary
            debugPrint(Localizable.noPhoto())
        }
        return imageArray
    }
}
