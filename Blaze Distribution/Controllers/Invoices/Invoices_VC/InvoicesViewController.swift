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
        
        let requestBulk = RequestBulkAPI()
        
        SyncService.sharedInstance().syncData()
//       WebServicesAPI.sharedInstance().BulkAPI(request: requestBulk) { (result:ResponseBulkRequest?,error:PlatformError?) in
//
//            if error != nil{
//                print(error?.message! ?? "Error")
//                return
//            }
//
//            self.saveData(jsonData: result?.invoice)
//
//        }
       
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Invoices"
       
    }
    
    func saveData(jsonData:ResponseArrayInvoice?){
        
         print("From jsonData: ",(jsonData))
         print("From jsonData?.values: ",(jsonData?.values?.count))
        if let values = jsonData?.values{
            
           
            
            for valu in values{
                
                let model: ModelInvoice = ModelInvoice()
                model.id                = valu.id
                model.companyId         = valu.companyId
                model.invoiceNumber     = valu.invoiceNumber
                model.dueDate           = valu.dueDate?.description
                model.balanceDue        = valu.balanceDue!
                model.company           = valu.company?.name
                model.balanceDue        = valu.balanceDue!
                model.contact           = valu.companyContact
                model.total             = valu.total!
                
                
                if let items = valu.items{
                    
                }else{
                    print("Items nil")
                }
                
                
                //Mapping Payment Info
                if let  paymentRec = valu.paymentsReceived{
                
                    for payment in paymentRec{
                        let paymentTemp             = ModelPaymentInfo()
                        paymentTemp.paymentDate     = payment.paidDate ?? 0
                        paymentTemp.referenceNumber = payment.referenceNo ?? ""
                        paymentTemp.amount          = payment.amountPaid ?? 0.0
                        model.paymentInfo.append(paymentTemp)
                    }
                }else{
                    
                    print("Payment info nil")
                }
                
                ///Mapping Shipping Manifests
                if valu.shippingManifests != nil, valu.shippingManifests!.count > 0 {
                    
                    for ship in valu.shippingManifests! {
                            let shipMen                 = ModelShipingMenifest()
                            shipMen.id                  = ship.id
                            shipMen.companyId           = ship.companyId
                            shipMen.driverName          = ship.driverName
                            shipMen.driverLicenseNumber = ship.driverLicenceNumber
                            shipMen.vehicleMake         = ship.vehicleMake
                            shipMen.vehicleModel        = ship.vehicleModel
                            shipMen.vehicleLicensePlate = ship.vehicleLicensePlate
                            shipMen.signaturePhoto      = ship.signaturePhoto
                            shipMen.receiverCompany     = ship.receiverCompany?.name
                            shipMen.receiverType        = ship.receiverCompany?.vendorType
                            shipMen.receiverContact     = ship.receiverCompany?.phone
                            shipMen.receiverLicense     = ship.receiverCompany?.licenseNumber
                        
                            if let add = ship.receiverAddress?.address{
                                
                                shipMen.receiverAddress?.id      = add.id
                                shipMen.receiverAddress?.city    = add.city
                                shipMen.receiverAddress?.address = add.address
                                shipMen.receiverAddress?.state   = add.state
                                
                            }
                        
                            model.shippingManifests.append(shipMen)
                    }
                }else{
                    print("From json shipingMenifest: Nil")
                }
                
                RealmManager().write(table: model)
               // print("----DataSave-----")
            }
        }
        print("----DataWrite-----")
        getData()

    }
    func getData(){
        
        SKActivityIndicator.show()
        valueDataObj =  RealmManager().readList(type: ModelInvoice.self)
        invoiceTableView.reloadData()
        SKActivityIndicator.dismiss()
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
        cell.createdByLabel.text =  temp.company
        
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
