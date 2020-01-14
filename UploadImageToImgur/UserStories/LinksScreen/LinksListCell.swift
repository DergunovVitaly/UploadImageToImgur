//
//  LinksListCell.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 14.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import UIKit

class LinksListCell: UITableViewCell {
    
    let urlLabel = UILabel()
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        urlLabel.numberOfLines = 0
        urlLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        urlLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(urlLabel)
        urlLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
