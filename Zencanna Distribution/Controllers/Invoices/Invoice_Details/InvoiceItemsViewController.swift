//
//  InvoiceItemsViewController.swift
//  shopperspick
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift
class InvoiceItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var invoiceItemList = List<ModelInvoiceItems>()
    @IBOutlet weak var invoiceItemsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        if deviceIdiom == .pad {
            invoiceItemsTableView.estimatedRowHeight = 70.0
        }else{
            invoiceItemsTableView.estimatedRowHeight = 60.0
        }
        
        
        AQLog.debug()
    }
    
    func getBatchSkuByProdId(prodId:String?) -> String{
        
        let ProductObj = RealmManager().readPredicate(type: ModelProduct.self, distinct: "productId", predicate:"productId = '\(prodId ?? "")'")
        if ProductObj.count > 0{
            if let Sku = ProductObj[0].sku{
                return Sku
            }else{
                return "--"
            }
        }else{
            return "--"
        }
    }
    
    // MARK: - UITableView Delegate/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoiceItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell

        //cell.productNameBtn.setTitle(invoiceItemList[indexPath.row].productName, for: UIControlState.normal)
        cell.lblProductName.text = invoiceItemList[indexPath.row].productName ?? "--"
        cell.batchNoLabel.text = self.getBatchSkuByProdId(prodId: invoiceItemList[indexPath.row].productId ?? "634")
        cell.noUnits.text = String(invoiceItemList[indexPath.row].quantity)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if deviceIdiom == .pad {
//            return 80
//        }
//        return 60
        return UITableViewAutomaticDimension
    }
}
