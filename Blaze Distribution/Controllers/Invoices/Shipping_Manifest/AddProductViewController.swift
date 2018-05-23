//
//  AddProductViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var invoiceItemsTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    var tempDataDict = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Product"
        // Do any additional setup after loading the view.
        //topView.dropShadow()
        
        tempDataDict = [["batch_no": "LLPWQ", "product_name": "Product 1", "quantity": "5 Units"], ["batch_no": "Batch ID", "product_name": "Product 2", "quantity": "5 Units"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableviewDelegate/Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
        cell.productNameBtn.setTitle("  \((tempDataDict[indexPath.row])["product_name"] as? String ?? "No value")" , for: .normal)
        cell.batchNoLabel.text = (tempDataDict[indexPath.row])["batch_no"] as? String
        cell.noUnits.text = (tempDataDict[indexPath.row])["quantity"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 70
        }
        return 60
    }
    
    // MARK: - UIButton Events
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuantityAndBatchViewController") as! QuantityAndBatchViewController        
        obj.tempDataDict = tempDataDict
        self.navigationController?.pushViewController(obj, animated: true)
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
