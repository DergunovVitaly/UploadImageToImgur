//
//  PhotoGridViewController.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 11.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class PhotoGridViewController: UIViewController {
    
    private var imageModelArray: [ImageModel] = []
    private let minimumItemSpacing: CGFloat = 5
    private let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    private let viewModel = PhotoGridViewModel()
    private let contentView = PhotoGridView()
    
    private var imageIdSet = Set<String>()
    
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
        navigationController?.pushViewController(LinksListViewController(), animated: true)
    }
    
    private func checkContainsId(id: String) -> Bool {
            return imageIdSet.contains(id)
    }
    
    func addURLstoDB(url: String) {
        DispatchQueue.global().async {
            guard let realm = try? Realm() else {
                self.presentErrorAlert()
                return
            }
            
            let newItem = UrlDBModel()
            newItem.urlString = url
            try? realm.write {
                realm.add(newItem)
            }
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
        cell.loadingState(isLoading: self.checkContainsId(id: self.imageModelArray[indexPath.row].id))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageId = self.imageModelArray[indexPath.row].id
         if self.checkContainsId(id: imageId) {
            return
        }
        self.imageIdSet.insert(imageId)
        contentView.collectionView.reloadItems(at: [indexPath])
            ImageUploadService.uploadImageModel(image: imageModelArray[indexPath.row]) { [unowned self] (result) in
                self.imageIdSet.remove(imageId)
                switch result {
                case .success(let url):
                    self.addURLstoDB(url: url.absoluteString)
                case .failure:
                    self.presentErrorAlert()
                }
                self.contentView.collectionView.reloadItems(at: [indexPath])
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
