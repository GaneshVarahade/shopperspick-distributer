//
//  InvoiceItemsViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class PurchaseOrderItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var model: ModelPurchaseOrder!

    override func viewDidLoad() {
        super.viewDidLoad()
        AQLog.debug()
        
        EventBus.sharedBus().subscribe(self,
                                       selector: #selector(self.getDataForPOObject(notification:)),
                                       eventType: EventBusEventType.SENDATA_PURCHASEORDER)
    }
    
    
    @objc func getDataForPOObject(notification: Notification) {
        model = notification.userInfo!["data"] as! ModelPurchaseOrder
         
        
    }
   
    func getBatchSkuByProdId(prodId:String?) -> String{
        
        let ProductObj = RealmManager().readPredicate(type: ModelProduct.self, distinct: "productId", predicate:"productId = '\(prodId ?? "")'")
        if let Sku = ProductObj[0].sku{
            return Sku
        }else{
            return "--"
        }
    }
    
    // MARK: - UITableView Delegate/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.productInShipment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
        let modelProduct = model.productInShipment[indexPath.row]
        
        //cell.productNameBtn.setTitle(modelProduct.name, for: .normal)
        cell.lblProductName.text = modelProduct.name ?? "--"
        cell.batchNoLabel.text = getBatchSkuByProdId(prodId: modelProduct.productId ?? "")
        cell.noUnits.text = "\(modelProduct.quantity)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if deviceIdiom == .pad {
            return 80.0
        }
        return 60.0
    }
        
}
