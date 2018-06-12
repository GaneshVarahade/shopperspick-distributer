//
//  InventoryViewController.swift
//  blaze
//
//  Created by pankaj on 04/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var inventoryTableView: UITableView!

    var inventoryData : [ModelInventory] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Inventory"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SKActivityIndicator.show()
        let requestBulk = RequestBulkAPI()
        WebServicesAPI.sharedInstance().BulkAPI(request: requestBulk) { (result:ResponseBulkRequest?,error:PlatformError?) in
            if error != nil{
                print(error?.message! ?? "Error")
                return
            }
            self.saveDataInvoice(jsonData: result?.invoice)
            self.saveDataInventory(jsonData: result?.inventoryTransfers)
        }
    }
    
    // MARK:- UISegmentController Valu Changed
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            nameLabel.isHidden = false
            requestLabel.isHidden = false
            dateLabel.isHidden = false
            requestLabel.text = "REQUEST #"
            createBtn.isHidden = false
            inventoryTableView.reloadData()
        }
        else {
            dateLabel.isHidden = true
            requestLabel.text = "QUANTITY"
            createBtn.isHidden = true
            inventoryTableView.reloadData()
        }
    }
    
    func saveDataInvoice(jsonData:ResponseArrayInvoice?){
        
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
                
                if let remaingProducts = valu.remainingProductInformations{
                    for remProd  in remaingProducts{
                        let temp               = ModelRemainingProduct()
                        temp.productId         = remProd.productId
                        temp.productName       = remProd.productName
                        temp.requestQuantity   = remProd.requestQuantity!
                        temp.remainingQuantity = remProd.remainingQuantity!
                        model.remainingProducts.append(temp)
                    }
                }else{
                    
                    print("Remaing nil..")
                }
                ///Mapping Items
                if let items = valu.items{
                    for item in items{
                        let itemTemp = ModelInvoiceItems()
                        itemTemp.productId = item.productId
                        itemTemp.productName = item.productName
                        itemTemp.batchId    = item.batchId
                        itemTemp.quantity = item.quantity
                        model.items.append(itemTemp)
                        
                    }
                    
                }else{
                    print("Items nil")
                }
                //Mapping Payment Info
                if let  paymentRec = valu.paymentsReceived{
                    
                    for payment in paymentRec{
                        let paymentTemp             = ModelPaymentInfo()
                        paymentTemp.id              = payment.id
                        paymentTemp.paymentDate     = payment.paidDate!
                        paymentTemp.referenceNumber = payment.referenceNo ?? ""
                        paymentTemp.amount          = payment.amountPaid!
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
            }
        }
        print("---Invoice Data Save---")
        
    }
    func saveDataInventory(jsonData:ResponseArrayInventory?){
        if let values = jsonData?.values{
            
            for value in values{
                let tempInventory = ModelInventory()
                tempInventory.id = value.id
                tempInventory.transferNo = value.transferNo
                tempInventory.fromInventoryName = value.fromInventoryName
                tempInventory.fromShopName = value.fromShopName
                tempInventory.toInventoryName = value.toInventoryName
                tempInventory.toShopId = value.toShopId
                tempInventory.toShopName = value.toShopName
                tempInventory.toInventoryName = value.toInventoryName
                RealmManager().write(table: tempInventory)
            }
        }else{
            print("Inventory is nil....")
        }
        SKActivityIndicator.dismiss()
        print("---Inventory Data Save---")
        getData()
    }
    func getData(){
        
        SKActivityIndicator.show()
        inventoryData =  RealmManager().readList(type: ModelInventory.self)
        inventoryTableView.reloadData()
        SKActivityIndicator.dismiss()
        print("----DataRead----- \(inventoryData.count)")
    }
    
   
     // MARK: - UIButton Events
    @IBAction func createTransferBtnPressed(_ sender: Any) {
      
    }
}

extension InventoryViewController{
    
    // MARk:- UITableview DataSource/ Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InventoryTableViewCell
        let temp   = inventoryData[indexPath.row]
        cell.nameLabel.text    =  "ASA"//temp.toInventoryName
        cell.requestLabel.text =  temp.transferNo
        if segmentControl.selectedSegmentIndex == 0 {
            cell.dateLabel.isHidden = false
            cell.dateLabel.text     = temp.fromShopId
        }
        else {
            cell.dateLabel.isHidden = true
        }
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
