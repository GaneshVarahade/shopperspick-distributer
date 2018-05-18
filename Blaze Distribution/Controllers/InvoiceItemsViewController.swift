//
//  InvoiceItemsViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

protocol InvoiceItemsDelegate {
    func getDataForInvoiceItems(dataDict: [[String:Any]])
}

class InvoiceItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var invoiceItemsDelegate:InvoiceItemsDelegate?
    var invoiceItemList = [[String:Any]]()

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
        invoiceItemList = (notification.userInfo!["data"] as! [String : Any])["products"] as! [[String:Any]]
    }
    
    func getDataForInvoiceItems(dataDict: [[String:Any]]) {
        print(dataDict)
        invoiceItemList = dataDict
    
        //print(displayDetailsDict)
    }

    
    // MARK: - UITableView Delegate/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15//invoiceItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
        cell.productNameBtn.setTitle("  \((invoiceItemList[indexPath.row])["product_name"] as? String ?? "No value")" , for: .normal)
        cell.batchNoLabel.text = (invoiceItemList[indexPath.row])["batch_no"] as? String
        cell.noUnits.text = (invoiceItemList[indexPath.row])["quantity"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 80
        }
        return 60
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
