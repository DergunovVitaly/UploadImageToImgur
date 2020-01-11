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
    private let imageArray = PhotoGridViewModel().grabPhotos()
    
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
        guard let flowLayout = contentView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        if UIApplication.shared.statusBarOrientation.isLandscape {
            if #available(iOS 11.0, *) {
                let size = (view.safeAreaLayoutGuide.layoutFrame.width / 5) -
                    flowLayout.minimumLineSpacing - flowLayout.sectionInset.left
                    flowLayout.itemSize = CGSize(width: size, height: size)
            } else {
                let size = (view.frame.width / 5) - flowLayout.minimumLineSpacing - flowLayout.sectionInset.left
                flowLayout.itemSize = CGSize(width: size, height: size)
            }
        } else {
            let size = (UIScreen.width / 3) - flowLayout.minimumLineSpacing - flowLayout.sectionInset.left
            flowLayout.itemSize = CGSize(width: size, height: size)
        }
        flowLayout.invalidateLayout()
        contentView.collectionView.reloadData()
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
