//
//  LinksListViewController.swift
//  UploadImageToImgur
//
//  Created by  Vitaly Dergunov on 14.01.2020.
//  Copyright © 2020 VitaliiDerhunov. All rights reserved.
//

import Foundation
import UIKit

class LinksListViewController: UIViewController {
    
    private let dataBaseService = DataBaseService()
    private let contentView = LinksListView()
    private var urlsArray = [""]
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlsArray = dataBaseService.readFromDataBase()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
}

extension LinksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LinksListCell.self))
            as? LinksListCell
            else { return UITableViewCell() }
        cell.urlLabel.text = urlsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: urlsArray[indexPath.row]) else { return }
        UIApplication.shared.open(url)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
