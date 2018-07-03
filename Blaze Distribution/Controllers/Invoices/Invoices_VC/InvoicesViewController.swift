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
class InvoicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    var filtered : [ModelInvoice] = []
    var valueDataObj : [ModelInvoice]!
    @IBOutlet weak var invoiceSegmentController: UISegmentedControl!
    @IBOutlet weak var invoicesSearchBar: UISearchBar!
    @IBOutlet weak var invoiceTableView: UITableView!
    @IBOutlet weak var dueDateTitle: UILabel!
    @IBOutlet weak var scanInvoiceBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.selectedIndex = 1
        invoiceTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
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
    
    //MARK:- SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filtered.removeAll()
        getData()
        
        for dict in valueDataObj {
            //print(dict)
            //find range of string 
            let invName : NSString! = dict.invoiceNumber! as NSString
            let range = invName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            
            if(range.location != NSNotFound){
               filtered.append(dict)
            }
            
        }
        //print(filtered)
        if !(invoicesSearchBar.text?.count==0)
        {            valueDataObj=filtered
        }else{
            invoicesSearchBar.endEditing(true)
        }
        //print(valueDataObj)
        invoiceTableView.reloadData()
        
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        invoicesSearchBar.endEditing(true)
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        invoicesSearchBar.endEditing(true)
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
        performSegue(withIdentifier: "goInvoiceDetail", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        let label = UILabel(frame: CGRect(x: 10, y: 20, width: tableView.frame.size.width - 10, height: 60))
        label.text = "Sorry! No Records found."
        label.textColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.center
        view.backgroundColor = UIColor.clear
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return valueDataObj?.count==0 ? 60.0 : 0.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goInvoiceDetail" {
        
            let nextVC = segue.destination as! InvoiceDetailsTableViewController
            let indexPath = invoiceTableView.indexPathForSelectedRow
            let invoiceObject = valueDataObj[(indexPath?.row)!]
                nextVC.tempData = invoiceObject
        }
    }
}
