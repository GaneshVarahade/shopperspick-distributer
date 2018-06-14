//
//  InvoicesViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
import RealmSwift
import Realm
class InvoicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    var valueDataObj : [ModelInvoice]!
    @IBOutlet weak var invoiceSegmentController: UISegmentedControl!
    @IBOutlet weak var invoicesSearchBar: UISearchBar!
    @IBOutlet weak var invoiceTableView: UITableView!
    @IBOutlet weak var dueDateTitle: UILabel!
    @IBOutlet weak var scanInvoiceBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.selectedIndex = 1
        setSearchBarUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .SYNCDATA)
    }
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .SYNCDATA)
    }
    @objc func syncFinished(_ notification: Notification){
        //Refresh data
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Invoices"
    }
    func getData(){
        valueDataObj =  RealmManager().readList(type: ModelInvoice.self)
        invoiceTableView.reloadData()
        print("----DataRead----- \(valueDataObj.count)")
    }
    
    private func getOpenInvoices() {
        valueDataObj = RealmManager().readPredicate(type: ModelInvoice.self, predicate: "invoiceStatus != \(InvoiceStatus.COMPLETED)")
        invoiceTableView.reloadData()
    }
    
    private func getCompleteInvoices() {
        valueDataObj = RealmManager().readPredicate(type: ModelInvoice.self, predicate: "invoiceStatus = \(InvoiceStatus.COMPLETED)")
        invoiceTableView.reloadData()
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
    
    //MARK:- Segment Value Change
    @IBAction func invoiceSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            //getOpenInvoices()
            dueDateTitle.text       = "DUE DATE"
            scanInvoiceBtn.isHidden = false
            invoiceTableView.reloadData()
        }
        else {
            //getCompleteInvoices()
            dueDateTitle.text       = "COMPLETED"
            scanInvoiceBtn.isHidden = true
            invoiceTableView.reloadData()
        }
    }
    // MARK:- UIButton Events
    @IBAction func scanInvoiceBtnPressed(_ sender: Any) {

    }
    // MARK:- UITouch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension InvoicesViewController{
    
    // MARK: - UITableview Datasource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if valueDataObj != nil{
            return valueDataObj.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell                  = tableView.dequeueReusableCell(withIdentifier: "cell") as! InvoicesTableViewCell
        let temp                  = valueDataObj[indexPath.row]
        cell.invoicesNoLabel.text = temp.invoiceNumber
        cell.dueDateLabel.text   =  temp.dueDate?.description
        cell.createdByLabel.text =  temp.salesPerson
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //performSegue(withIdentifier: "goDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goDetails" {
        
            let nextVC = segue.destination as! InvoiceDetailsTableViewController
            let indexPath = invoiceTableView.indexPathForSelectedRow
            let invoiceObject = valueDataObj[(indexPath?.row)!]
                nextVC.tempData = invoiceObject
        }
    }
}
