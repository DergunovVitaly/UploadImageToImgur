//
//  PhotoGridViewController.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 11.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import UIKit

class PhotoGridViewController: UIViewController {
    
    private let contentView = PhotoGridView()
    private let viewModel = PhotoGridViewModel()
    private var imageArray: [UIImage] = []
    private var itemsPerRow: CGFloat = 3
    private let minimumItemSpacing: CGFloat = 5
    let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
        setupNavigationController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.grabPhotos { [unowned self] result in
            switch result {
            case .success(let image):
                self.imageArray = image
            case .failure:
                self.showAlert(alertText: "Error", alertMessage: "Error", buttonTitle: "Ok")
            }
        }
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
    
    private func setupNavigationController() {
        title = Localizable.photoLibrary()
        if #available(iOS 13.0, *) {
            let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
            let linkSymbolImage = UIImage(systemName: Localizable.link(), withConfiguration: largeConfiguration)
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: linkSymbolImage,
                style: .done, target: self,
                action: #selector(tapOnLinkButton))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: Localizable.link()),
                style: .done, target: self,
                action: #selector(tapOnLinkButton))
        }
    }
    
    @objc func tapOnLinkButton() {
        debugPrint("taping link button")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        itemsPerRow = UIApplication.shared.statusBarOrientation.isLandscape ? 5 : 3
    }
}

extension PhotoGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PhotoGridCell.self),
            for: indexPath) as? PhotoGridCell else { return UICollectionViewCell() }
        cell.thumbnailImage = imageArray[indexPath.row]
        return cell
    }
    
}

extension PhotoGridViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
}
