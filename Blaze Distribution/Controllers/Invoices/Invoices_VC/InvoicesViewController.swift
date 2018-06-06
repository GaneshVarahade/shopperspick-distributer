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
        SKActivityIndicator.show()
        let invoiceReq = RequestInvoices()
        invoiceReq.shopId = "56cf846ee38179985229e59e"
        
        WebServicesAPI.sharedInstance().InvoiceAPI(request: invoiceReq) { (result:ResponseGetAllInvoices?, error:PlatformError?) in
            SKActivityIndicator.dismiss()
            if error != nil {
                print(error?.message! ?? "Error")
                return
            }
            
            self.saveData(jsonData: result)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Invoices"
       
    }
    
    func saveData(jsonData:ResponseGetAllInvoices?){
        
        if let values = jsonData?.values{
            for valu in values{
               // print("From json id: " + (valu.id)!)
                let model: ModelInvoice = ModelInvoice()
                model.id                = valu.id
                model.companyId         = valu.companyId
                model.shopId            = valu.shopId
                model.invoiceNumber     = valu.invoiceNumber
                model.customerId        = valu.customerId
                model.dueDate           = valu.dueDate?.description
                model.employeeName      = valu.employeeName
                if valu.shippingManifests != nil, valu.shippingManifests!.count > 0 {
                    //print("From json shipingMenifest: " + (valu.shippingManifests![0].shippingManifestNo)!)
                    
                    if let shippingManifests = valu.shippingManifests {
                        
                        for ship in shippingManifests {
                            let shipMen                 =   ModelShipingMenifest()
                            shipMen.id                  =   ship.id
                            shipMen.companyId           =   ship.companyId
                            shipMen.shopId              =   ship.shopId
                            shipMen.invoiceId           =   ship.invoiceId
                            shipMen.shippingManifestNo  =   ship.shippingManifestNo
                            shipMen.invoiceAmount       =   ship.invoiceAmount ?? 0.0
                            shipMen.invoiceBalanceDue   =   ship.invoiceBalanceDue ?? 0.0
                            
                           // print("ModelShpping: "+shipMen.getString())
                            
                            model.shippingManifests.append(shipMen)
                        }
                    }
                    
                }else{
                   // print("From json shipingMenifest: Nil")
                }
                //print("ModelInvoice: "+model.getString())

                RealmManager().write(table: model)
               // print("----DataSave-----")
                
            }
        }
        
        print("----DataWrite-----")
        getData()
    }
    
    func getData(){
        
        valueDataObj =  RealmManager().readList(type: ModelInvoice.self)
        invoiceTableView.reloadData()
        print("----DataRead----- \(valueDataObj.count)")

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InvoicesTableViewCell
        
        let temp = valueDataObj[indexPath.row]
        cell.invoicesNoLabel.text = temp.invoiceNumber
        cell.dueDateLabel.text   =  temp.dueDate?.description
        cell.createdByLabel.text =  temp.employeeName
        
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
    
}
