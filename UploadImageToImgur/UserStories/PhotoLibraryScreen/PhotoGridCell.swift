//
//  PhotoGridCell.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 11.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import UIKit

class PhotoGridCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    var thumbnailImage: UIImage! {
        didSet {
            imageView.image = thumbnailImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func loadingState(isLoading: Bool) {
        isLoading ? activityView.startAnimating() : activityView.stopAnimating()
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(activityView)
        activityView.layer.cornerRadius = 10
        activityView.color = .blue
        activityView.backgroundColor = .white
        activityView.snp.makeConstraints { (make) in
            make.size.equalTo(55)
            make.center.equalToSuperview()
        }
    }
}
