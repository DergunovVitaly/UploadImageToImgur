//
//  PhotoGridView.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 11.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//
import Foundation
import UIKit

class PhotoGridView: UIView {
    
    let activityView = UIActivityIndicatorView(style: .whiteLarge)
    private(set) var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        collectionView.backgroundColor = .white
        collectionView.register(PhotoGridCell.self, forCellWithReuseIdentifier: String(describing: PhotoGridCell.self))
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
        addSubview(activityView)
        activityView.color = .black
        activityView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
