//
//  InvoiceDetailsTableViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class InvoiceDetailsTableViewController: UITableViewController, FixedInvoiceDetailsDelegate {
    var tempData: ModelInvoice?
    var fixedDetailsTableVC: FixedInvoiceDetailsTableViewController?
    var invoiceItemsVC: InvoiceItemsViewController?
    var paymentItemsVC: InvoicePaymentsViewController?
    var shippingItemsVC: ShippingItemsViewController?

    @IBOutlet weak var duePaymentLabel: UILabel!
    @IBOutlet weak var invoiceDetailsView: UIView!
    @IBOutlet weak var itemsInInvoiceView: UIView!
    @IBOutlet weak var paymentsTitleView: UIView!
    @IBOutlet weak var shippingManifestView: UIView!
    var itemsList :[ModelInvoiceItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let invoiceData = tempData{
            self.title = invoiceData.invoiceNumber
            self.duePaymentLabel.text = "$\(invoiceData.balanceDue) \(NSLocalizedString("dueof", comment: "")) $\(invoiceData.total)"
            fixedDetailsTableVC?.getDataForFixedInvoices(data:invoiceData)
           // print(invoiceData)
            
        }else{
            
            return
        }
        
        
    }
 
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
            fixedDetailsTableVC = segue.destination as? FixedInvoiceDetailsTableViewController
            fixedDetailsTableVC!.fixedInvoiceDelegate = self
        }
        else if segue.identifier == "invoiceItemsSegue" {
            invoiceItemsVC = segue.destination as? InvoiceItemsViewController
            if let data = tempData{
                invoiceItemsVC?.invoiceItemList = (data.items)
            }else{
                return
            }
        }
        else if segue.identifier == "paymentItemsSegue" {
            paymentItemsVC = segue.destination as? InvoicePaymentsViewController
            if let data = tempData{
            paymentItemsVC?.paymentList = (data.paymentInfo)
            }else{
                return
            }
        }
        else if segue.identifier == "shippingItemsSegue" {
            shippingItemsVC = segue.destination as? ShippingItemsViewController
            if let data = tempData{
            shippingItemsVC?.shippingData = (data.shippingManifests)
            }else{
                return
            }
        }
    }
}

extension InvoiceDetailsTableViewController{
    
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
                return CGFloat(80 * (tempData != nil ? (tempData?.items.count)! : 0) )
            }
            else {
                return CGFloat(60 * (tempData != nil ? (tempData?.items.count)! : 0)  )
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
                return CGFloat(70 * (tempData != nil ? (tempData?.paymentInfo.count)! : 0))
            }
            else{
                return CGFloat(50 * (tempData != nil ? (tempData?.paymentInfo.count)! : 0))
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
                return CGFloat(70 * (tempData != nil ? (tempData?.shippingManifests.count)! : 0))
            }
            else {
                return CGFloat(50 * (tempData != nil ? (tempData?.shippingManifests.count)! : 0))
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
    
    func getDataForFixedInvoices(dataDict: ModelInvoice) {
        print(dataDict)
    }
    
}
