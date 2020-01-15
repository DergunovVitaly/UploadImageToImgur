//
//  LinksListView.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 14.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import UIKit

class LinksListView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(LinksListCell.self, forCellReuseIdentifier: String(describing: LinksListCell.self))
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
