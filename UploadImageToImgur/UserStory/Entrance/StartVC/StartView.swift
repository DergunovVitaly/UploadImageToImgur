//
//  StartView.swift
//  HomeNotes
//
//  Created by Vitalii Derhunov on 25.10.2019.
// 
//

import Foundation
import UIKit
import SnapKit

class StartView: UIView {
    
    private let imageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(imageView)
        imageView.image = R.image.onboarding()
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
