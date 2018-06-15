//
//  InvoiceItemsViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift
class InvoiceItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var invoiceItemList = List<ModelInvoiceItems>()
    override func viewDidLoad() {
        super.viewDidLoad()
        AQLog.debug()
        
        EventBus.sharedBus().subscribe(self,
                                       selector: #selector(self.getDataForPOObject(notification:)),
                                       eventType: EventBusEventType.SENDATA_PURCHASEORDER)
    }
    
    
    @objc func getDataForPOObject(notification: Notification) {
        //model = notification.userInfo!["data"] as! ModelPurchaseOrder
        
        
    }
    
    // MARK: - UITableView Delegate/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell

        cell.productNameBtn.setTitle(invoiceItemList[indexPath.row].productName, for: UIControlState.normal)
        cell.batchNoLabel.text = invoiceItemList[indexPath.row].batchId ?? "000"
        cell.noUnits.text = String(invoiceItemList[indexPath.row].quantity)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 80
        }
        return 60
    }
}
