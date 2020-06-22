//
//  Completed_InvoiceItemsViewController.swift
//  shopperspick
//
//  Created by Fidel iOS on 16/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit


class Completed_InvoiceItemsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
  //  var invoiceItemsDelegate:InvoiceItemsDelegate?
    var invoiceItem = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.getProductDetails(notification:)), name: NSNotification.Name(rawValue: "PO_DETAILS"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Selector Methods
    
    @objc func getProductDetails(notification: NSNotification) {
        invoiceItem = (notification.userInfo!["data"] as! [String : Any])["products"] as! [[String:Any]]
        //print(invoiceItem)
        
    }
    
    func getDataForInvoiceItems(dataDict: [[String:Any]]) {
        //print(dataDict)
        invoiceItem = dataDict
        
        //print(displayDetailsDict)
    }
    
    
    // MARK: - UITableView Delegate/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoiceItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
       // cell.productNameBtn.setTitle("  \((invoiceItem[indexPath.row])["product_name"] as? String ?? "No value")" , for: .normal)
        cell.lblProductName.text = "  \((invoiceItem[indexPath.row])["product_name"] as? String ?? "No value")"
        cell.batchNoLabel.text = (invoiceItem[indexPath.row])["batch_no"] as? String
        cell.noUnits.text = (invoiceItem[indexPath.row])["quantity"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if deviceIdiom == .pad {
            return 80
        }
        return 60
    }
}
