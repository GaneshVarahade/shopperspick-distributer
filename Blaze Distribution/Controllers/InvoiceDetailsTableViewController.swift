//
//  InvoiceDetailsTableViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class InvoiceDetailsTableViewController: UITableViewController {
    
    
    var tempData: [String:Any] = [:]
//    var fixedDetailsTableVC: FixedInvoiceDetailsTableViewController?
//    var invoiceItemsVC: InvoiceItemsViewController?
//    var paymentItemsVC: PaymentItemsViewController?
//    var shippingItemsVC: ShippingItemsViewController?

    @IBOutlet weak var duePaymentLabel: UILabel!
    @IBOutlet weak var invoiceDetailsView: UIView!
    @IBOutlet weak var itemsInInvoiceView: UIView!
    @IBOutlet weak var paymentsTitleView: UIView!
    @IBOutlet weak var shippingManifestView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "INV-001"
        
        tempData = ["invoice_details":["invoice_no":"INV-001","due_date":"05/20/2019","company":"Matt's Retailer","contact":"Matt Smith","total":"$5500.00","balance":"$2500.00"],
                    "items":[["product_name":"Product 1","batch_no":"LLPWQ","quantity":"5 Units"],["product_name":"Product 2","batch_no":"LLPWFDQ","quantity":"2 Units"],["product_name":"Product 3","batch_no":"LLPWQ","quantity":"8 Units"]],
                    "payments":[["pay_id":"PAY-001","amount":"$1000.00"],["pay_id":"PAY-002","amount":"$1500.00"]],
                    "payments_str":"+$500.00 Due of $3000.00","shipping_manifest":[["id":"SHP-001","status":"Shipped"],["id":"SHP-002","status":"Packed"]]]
        
       
//        fixedDetailsTableVC?.getDataForFixedInvoices(dataDict: tempData["invoice_details"] as! [String
//            :Any])
//        invoiceItemsVC?.getDataForInvoiceItems(dataDict: tempData["items"] as! [[String:Any]])
//        paymentItemsVC?.getDataForPaymentItems(dataDict: tempData["payments"] as! [[String:Any]])
//        shippingItemsVC?.getDataForShippingItems(dataDict: tempData["shipping_manifest"] as! [[String:Any]])
//
       // duePaymentLabel.text = tempData["payments_str"] as? String
//        invoiceDetailsView.dropRightBottomShadow()
//        itemsInInvoiceView.dropShadow()
//        paymentsTitleView.dropShadow()
//        shippingManifestView.dropShadow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
            
        case 1:
            if deviceIdiom == .pad {
                return (70 * 6)
            }
            else {
                return CGFloat(50 * 6)
            }
            
        case 2:
            if deviceIdiom == .pad {
                return 90
            }
            else {
                return 70
            }
            
        case 3:
            if deviceIdiom == .pad {
                return CGFloat(80 * 5) //(tempData["items"] as? [[String:Any]])!.count)
            }
            else {
                return CGFloat(60 * 5)//(tempData["items"] as? [[String:Any]])!.count)
            }
            
        case 4:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
            
        case 5:
            if deviceIdiom == .pad {
                return CGFloat(70 * (tempData["payments"] as? [[String:Any]])!.count)
            }
            else{
                return CGFloat(50 * (tempData["payments"] as? [[String:Any]])!.count)
            }
            
        case 6:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
            
        case 7:
            if deviceIdiom == .pad {
                return CGFloat(70 * (tempData["shipping_manifest"] as? [[String:Any]])!.count)
            }
            else {
                return CGFloat(50 * (tempData["shipping_manifest"] as? [[String:Any]])!.count)
            }
            
        case 8:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
            
        default:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK:- Container VC Delegates
    func getDataForFixedInvoices(dataDict: [String : Any]) {
        
    }
    
    func getDataForShippingItems(dataDict: [[String : Any]]) {
        
    }
    
    func getDataForPaymentItems(dataDict: [[String : Any]]) {
        
    }
    
    func getDataForInvoiceItems(dataDict: [[String : Any]]) {
        
    }
    
    // MARK:- UIButton Events
    
    @IBAction func addPaymentBtnPressed(_ sender: Any) {
        //let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPaymentTableViewController")
        //self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func addShippingManifestBtnPressed(_ sender: Any) {
        //let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShippingManifestViewController")
        //self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  
        if segue.identifier == "fixedInvoiceSegue" {
           // fixedDetailsTableVC = segue.destination as? FixedInvoiceDetailsTableViewController
           // fixedDetailsTableVC!.fixedInvoiceDelegate = self
        }
        else if segue.identifier == "invoiceItemsSegue" {
           // invoiceItemsVC = segue.destination as? InvoiceItemsViewController
           // invoiceItemsVC?.invoiceItemsDelegate = self
        }
        else if segue.identifier == "paymentItemsSegue" {
           // paymentItemsVC = segue.destination as? PaymentItemsViewController
           // paymentItemsVC?.paymentItemsDelegate = self
        }
        else if segue.identifier == "shippingItemsSegue" {
           // shippingItemsVC = segue.destination as? ShippingItemsViewController
           // shippingItemsVC?.shippingItemsDelegate = self
        }
    }
}
