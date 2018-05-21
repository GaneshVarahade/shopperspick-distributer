//
//  InvoicesViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class InvoicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tempDataList : [[String:Any]] = []
    
    @IBOutlet weak var invoiceSegmentController: UISegmentedControl!
    @IBOutlet weak var invoicesSearchBar: UISearchBar!
    @IBOutlet weak var invoiceTableView: UITableView!
    @IBOutlet weak var dueDateTitle: UILabel!
    @IBOutlet weak var scanInvoiceBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.selectedIndex = 1
        
        setSearchBarUI()
        
        tempDataList = [["created_by":"Justin Bruss","invoice_no":"123456","due_date":"04/23/2018"],["created_by":"Justin Bruss","invoice_no":"123456","due_date":"04/23/2018"],["created_by":"Justin Bruss","invoice_no":"123456","due_date":"04/23/2018"],["created_by":"Justin Bruss","invoice_no":"123456","due_date":"04/23/2018"],["created_by":"Justin Bruss","invoice_no":"123456","due_date":"04/23/2018"],["created_by":"Justin Bruss","invoice_no":"123456","due_date":"04/23/2018"],["created_by":"Justin Bruss","invoice_no":"123456","due_date":"04/23/2018"],["created_by":"Justin Bruss","invoice_no":"123456","due_date":"04/23/2018"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Invoices"
    }
    
    // MARK:- Utilities
    func setSearchBarUI() {
        invoicesSearchBar.layer.borderWidth = 1;
        invoicesSearchBar.layer.borderColor = UIColor.white.cgColor
        for s in invoicesSearchBar.subviews[0].subviews {
            if s is UITextField {
                s.layer.borderWidth = 0.5
                s.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
    
    
    // MARK: - UITableview Datasource/Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InvoicesTableViewCell
        
        cell.invoicesNoLabel.text = (tempDataList[indexPath.row])["invoice_no"] as? String
        cell.dueDateLabel.text = (tempDataList[indexPath.row])["due_date"] as? String
        cell.createdByLabel.text =  (tempDataList[indexPath.row])["created_by"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 60
        }
        else {
            return 44
        }
    }
    
    
    //MARK:- Segment Value Change
    @IBAction func invoiceSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dueDateTitle.text = "DUE DATE"
            scanInvoiceBtn.isHidden = false
            invoiceTableView.reloadData()
        }
        else {
            dueDateTitle.text = "COMPLETED"
            scanInvoiceBtn.isHidden = true
            invoiceTableView.reloadData()
        }
    }
    
    // MARK:- UIButton Events
    
    @IBAction func scanInvoiceBtnPressed(_ sender: Any) {
       // let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScanInvoiceViewController")
       // self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // MARK:- UITouch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
