//
//  ShippingItemsViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import  RealmSwift

protocol ShippingItemsDelegate {
    func getDataForShippingItems(dataDict: [[String:Any]])
}

class ShippingItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var shippingItemsDelegate:ShippingItemsDelegate?
    var shippingData = List<ModelShipingMenifest>()

    override func viewDidLoad() {
        super.viewDidLoad()
       // print(shippingData)
    }
}

extension ShippingItemsViewController{
    
    // MARK: - UITableviewDatasource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shippingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shippingCell") as! ShippingManifestTableViewCell
        cell.shippingId.text = (shippingData[indexPath.row]).shippingManifestNo
        cell.shippingStatusLabel.text = (shippingData[indexPath.row]).invoiceStatus
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 70
        }
        return 50
    }
}
