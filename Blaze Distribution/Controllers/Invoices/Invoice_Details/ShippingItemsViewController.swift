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
    func getDataForShippingItems(dataDict: ModelShipingMenifest)
}

class ShippingItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var shippingItemsDelegate:ShippingItemsDelegate?
    var shippingData = List<ModelShipingMenifest>()
    
    @IBOutlet weak var shipingTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       // print(shippingData)
    }
    
    func shippingList(shippingData: List<ModelShipingMenifest>){
        self.shippingData = shippingData
        shipingTable.reloadData()
    }
}

extension ShippingItemsViewController{
    
    // MARK: - UITableviewDatasource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shippingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shippingCell") as! ShippingManifestTableViewCell
        cell.shippingIdButton.setTitle((shippingData[indexPath.row]).shippingManifestNo, for: .normal)
        cell.shippingStatusButton.setTitle((shippingData[indexPath.row]).invoiceStatus ?? "Shipped", for: .normal)
        
        cell.shippingStatusButton.tag = indexPath.row
        cell.shippingIdButton.tag = indexPath.row
        cell.shippingIdButton.addTarget(self, action: #selector(self.showManifestDetails(sender:)), for: .touchUpInside)
        cell.shippingStatusButton.addTarget(self, action: #selector(self.showManifestDetails(sender:)), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 70
        }
        return 50
    }
    
    // MARk: - UIButton Events
    
    @objc func showManifestDetails(sender: UIButton) {
        shippingItemsDelegate?.getDataForShippingItems(dataDict: shippingData[sender.tag])
    }
}
