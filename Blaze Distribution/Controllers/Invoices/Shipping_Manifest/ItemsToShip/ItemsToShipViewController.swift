//
//  ItemsToShipViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

protocol changeInShippingDelegate {
    func changeUI()
}

class ItemsToShipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var confirmAllBtn: UIButton!
    @IBOutlet weak var invoiceItemsTableView: UITableView!
    
    var tempDataDict = [[String:Any]]()
    var itemsDelegate:changeInShippingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //topView.dropShadow()
        
        if tempDataDict.count > 0 {
            confirmAllBtn.isEnabled = true
            confirmAllBtn.backgroundColor = UIColor.orange
        }
        else {
            confirmAllBtn.isEnabled = false
            confirmAllBtn.backgroundColor = UIColor.lightGray
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.getItemsForInvoice(notification:)), name: Notification.Name("INVOICE_ITEMS"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Selector method
    @objc func getItemsForInvoice(notification: Notification){
        //Take Action on Notification
        print(notification.userInfo!["items"]!)
        tempDataDict = notification.userInfo!["items"]! as! [[String : Any]]
        if tempDataDict.count > 0 {
            self.invoiceItemsTableView.reloadData()
            confirmAllBtn.isEnabled = true
            confirmAllBtn.backgroundColor = UIColor.orange
        }
        else {
            confirmAllBtn.isEnabled = false
            confirmAllBtn.backgroundColor = UIColor.lightGray
        }
        
    }
    
    // MARK: - UITableviewDelegate/Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
        cell.productNameBtn.setTitle(" \((tempDataDict[indexPath.row])["product_name"] as? String ?? "No value")" , for: .normal)
        cell.batchNoLabel.text = (tempDataDict[indexPath.row])["batch_no"] as? String
        cell.noUnits.text = (tempDataDict[indexPath.row])["quantity"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 80
        }
        return 60
    }

    // MARK: - UIButton Events
    @IBAction func addItemBtnPressed(_ sender: Any) {
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddProductViewController")
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {

        itemsDelegate?.changeUI()
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
