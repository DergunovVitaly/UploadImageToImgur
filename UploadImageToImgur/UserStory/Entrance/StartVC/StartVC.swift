//
//  StartVC.swift
//  HomeNotes
//
//  Created by Vitalii Derhunov on 25.10.2019.
//  
//

import Foundation
import UIKit

class StartVC: UIViewController {
    
    private let contentView = StartView()
    
    override func loadView() {
        view = contentView
        setupNavigationController()
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
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
}
