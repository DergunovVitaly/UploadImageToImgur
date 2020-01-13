//
//  PhotoGridViewController.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 11.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import UIKit
import Moya

class PhotoGridViewController: UIViewController {
    
    private var imageModelArray: [ImageModel] = []
    private let minimumItemSpacing: CGFloat = 5
    private let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    private let viewModel = PhotoGridViewModel()
    private let contentView = PhotoGridView()
    
    var imageIdSet = Set<String>()
    
    var isLoading = false
  
    private var itemsPerRow: CGFloat {
        return UIApplication.shared.statusBarOrientation.isLandscape ? 5.0 : 3.0
    }
    
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
        grabPhotos()
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
    
    private func grabPhotos() {
        viewModel.grabPhotos { [unowned self] result in
            switch result {
            case .success(let image):
                self.imageModelArray = image
                for item in image {
                    self.imageIdSet.insert(item.id)
                }
            case .failure:
                self.presentErrorAlert()
            }
        }
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
    
    private func presentShare(image: UIImage, url: URL) {
        let alert = UIAlertController(title: "Your card is ready!", message: nil, preferredStyle: .actionSheet)
        
        let openAction = UIAlertAction(title: "Open in Imgur", style: .default) { _ in
            UIApplication.shared.open(url)
        }
        
        let shareAction = UIAlertAction(title: "Share", style: .default) { [weak self] _ in
            let share = UIActivityViewController(activityItems: ["Check out my iMarvel card!", url, image],
                                                 applicationActivities: nil)
            share.excludedActivityTypes = [.airDrop, .addToReadingList]
            self?.present(share, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(openAction)
        alert.addAction(shareAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func checkContainsId(id: String) -> Bool {
        if imageIdSet.contains(id) {
            return true
        } else {
            return false
        }
    }
}

extension PhotoGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PhotoGridCell.self),
            for: indexPath) as? PhotoGridCell else { return UICollectionViewCell() }
        cell.thumbnailImage = imageModelArray[indexPath.row].image
        cell.loadingState(isLoading: isLoading)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isLoading = self.checkContainsId(id: self.imageModelArray[indexPath.row].id)
        contentView.collectionView.reloadItems(at: [indexPath])
        if self.checkContainsId(id: self.imageModelArray[indexPath.row].id) {
        ImageUploadService.uploadImageModel(image: imageModelArray[indexPath.row]) { [unowned self] (result) in
            switch result {
            case .success(let url):
                self.imageIdSet.remove(self.imageModelArray[indexPath.row].id)
                self.isLoading = self.checkContainsId(id: self.imageModelArray[indexPath.row].id)
                self.contentView.collectionView.reloadItems(at: [indexPath])
//                self.presentShare(image: self.imageModelArray[indexPath.row].image, url: url)
            case .failure:
                self.presentErrorAlert()
            }
        }
        } else {
            self.presentAlert(alertText: "Alert", alertMessage: "This image has been uploaded.", buttonTitle: "Ok")
        }
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
