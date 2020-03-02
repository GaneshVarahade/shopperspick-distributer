//
//  InvoiceDetailsTableViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

protocol ShippingMenifestConfirmDelegate {
    func confirmShippingMenifest(modelShipping: ModelShipingMenifest)
}

class InvoiceDetailsTableViewController: UITableViewController, FixedInvoiceDetailsDelegate,AddPaymentDelegate,InvoicePaymentsDetailsDelegate, ShippingItemsDelegate,ShippingMenifestConfirmDelegate {
    
    func confirmShippingMenifest(modelShipping: ModelShipingMenifest) {
        
        for obj in modelShipping.selectedItems {
            
            for product in (tempData?.remainingProducts)! {
                if obj.productId == product.productId {
                    product.remainingQuantity -= obj.requestQuantity
                }
            }
        }
        tempData?.shippingManifests.append(modelShipping)
    }
    
    
//    func confirmShippingMenifest(modelInvoice: ModelInvoice) {
//        self.tempData = modelInvoice
//
//        print("\(tempData?.shippingManifests.count)")
//    }
    

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
    @IBOutlet weak var completeInvoicButton: UIButton!
    
    var itemsList :[ModelInvoiceItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        
          if let invoiceData = tempData {
                    self.title = invoiceData.invoiceNumber
        //            invoiceData.balanceDue = 25.23652
        //            invoiceData.total = 35.63589
                    self.duePaymentLabel.text = String(format: "$%.2f \(NSLocalizedString("dueof", comment: "")) $%.2f", invoiceData.balanceDue, invoiceData.total)
                    fixedDetailsTableVC?.getDataForFixedInvoices(data:invoiceData)
                    
                    if invoiceData.invoiceStatus == InvoiceStatus.COMPLETED.rawValue {
                        completeInvoicButton.isHidden = true
                    }
                    
                } else {
                    return
                }
        
        getDataFromShippingList(dataDict: tempData)
    }
    
    // MARK:- Container VC Delegates
    func getDataForFixedInvoices(dataDict: [String : Any]) {
        
    }
    
    func getDataForShippingItems(dataDict: ModelShipingMenifest) {
        self.performSegue(withIdentifier: "addManifestInfoSegue", sender: dataDict)
    }
    
    func getDataForPaymentItems(dataDict: [[String : Any]]) {
        
    }
    
    func getDataForInvoiceItems(dataDict: [[String : Any]]) {
        
    }
    
    // MARK:- UIButton Events
    
    @IBAction func addPaymentBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func addShippingManifestBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func onCompleteInvoicePressed(sender: Any){
        
//        guard let tempData = tempData else {
//            return
//        }
//        tempData.updated = true
//        tempData.putBulkError = ""
//        RealmManager().write(table: tempData)
//        //Write timeStamp
//        UtilWriteLogs.writeLog(timesStamp: UtilWriteLogs.curruntDate, event:activityLogEvent.Invoices.rawValue , objectId: tempData.id, lastSynch:nil)
//
//        RealmManager().read(type: ModelInvoice.self, primaryKey: tempData.invoiceNumber!)
//
//        let sigmodel = getModelSignature()
//        if sigmodel.count > 0{
//
//            //Create request for signature
//                    let arrayModelSignature = sigmodel
//                    let requestSignature = RequestSignature()
//                    var modelSign = ModelSignature()
//                    modelSign = arrayModelSignature[0]
//                    requestSignature.name = modelSign.name
//                    requestSignature.invoiceId = modelSign.invoiceId
//                    requestSignature.shippingMainfestId = modelSign.shippingMainfestId
//
//            SKActivityIndicator.show()
//            SyncService.sharedInstance().postInvoiceWithSignature(requestSignature: requestSignature, sigId: modelSign.id!) { (error : PlatformError?) in
//                if error != nil{
//                    SKActivityIndicator.dismiss()
//                    self.showAlert(title: "Message", message: "Error while upload image", closure: {})
//                }else{
//                    SyncService.sharedInstance().callPostAPI(completion: { (error1 :PlatformError?) in
//                        if error1 != nil{
//                            SKActivityIndicator.dismiss()
//                            self.showAlert(title: "Message", message: NSLocalizedString("ServerError", comment: ""), closure: {})
//                        }else{
//                            SKActivityIndicator.dismiss()
//                            SyncService.sharedInstance().syncData()
//                            self.navigationController?.popViewController(animated: true)
//                        }
//                    })
//
//                }
//            }
//        }else{
//            SyncService.sharedInstance().callPostAPI(completion: { (error1 :PlatformError?) in
//                if error1 != nil{
//                    SKActivityIndicator.dismiss()
//                    self.showAlert(title: "Message", message: NSLocalizedString("ServerError", comment: ""), closure: {})
//                }else{
//                    SKActivityIndicator.dismiss()
//                    SyncService.sharedInstance().syncData()
//                    self.navigationController?.popViewController(animated: true)
//                }
//            })
//        }
//        //SyncService.sharedInstance().syncData()
//
//
       
    }
    
    private func getModelSignature() ->[ModelSignature] {
        return RealmManager().readPredicate(type: ModelSignature.self, predicate: "updated = true")
    }
    
    private func isManifestAvailable() -> Bool{
        var available = true
        if let manifest = tempData?.remainingProducts{
            if manifest.count  > 0{
                for item in manifest{
                    if(Int(item.remainingQuantity) == 0){
                        available = false
                    }
                }
            }else{
               available = false
            }
        }else{
            available = false
        }
        return available
    }
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "addPaymentSegue" {
            if(tempData?.invoiceStatus == "DRAFT" || tempData?.invoicePaymentStatus == "PAID"){
                showToast(NSLocalizedString("InvDetail_Validation1", comment: ""))
                return false
            }else if let due = tempData?.balanceDue, due <= 0 {
                showToast(NSLocalizedString("InvDetail_Validation2", comment: ""))
                return false
            }
            return true
        }else  if identifier == "addManifestInfoSegue" {
            if(tempData?.invoiceStatus == "DRAFT"){
                showToast(NSLocalizedString("InvDetail_Validation3", comment: ""))
                return false
            }else if (tempData?.invoiceStatus == "COMPLETED")
            {
                showToast(NSLocalizedString("InvDetail_Validation4", comment: ""))
                return false
            }else if (!isManifestAvailable()){
                showToast("No remainig product found to ship for this invoice.")
                return false
            }
        }
        return true
    }

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
            paymentItemsVC?.paymentInvoiceDelegate = self
            if let data = tempData{
            paymentItemsVC?.paymentList = (data.paymentInfo)
                paymentItemsVC?.invoiceId = data.invoiceNumber ?? "INV"
            }else{
                return
            }
        }
        else if segue.identifier == "shippingItemsSegue" {
            shippingItemsVC = segue.destination as? ShippingItemsViewController
            shippingItemsVC?.shippingItemsDelegate = self
            if let data = tempData{
            shippingItemsVC?.shippingData = (data.shippingManifests)
            }else{
                return
            }
        }
        else if segue.identifier == "addPaymentSegue" {
                let obj = segue.destination as! AddPaymentTableViewController
                obj.paymentDelegate = self
                obj.invoiceObj = tempData
        
        }
        else if segue.identifier == "addManifestInfoSegue" {
            let obj = segue.destination as! ShippingManifestViewController
            obj.invoiceDetailsDict = tempData
            obj.newShipDelaget = self
            
            if let sender = sender as? ModelShipingMenifest {
                obj.isAddManifest = false
                obj.modelShippingMen = sender
            }
            else {
                
                obj.isAddManifest = true
                obj.modelShippingMen = ModelShipingMenifest()
                obj.modelShippingMen?.shippingManifestNo = HexGenerator.sharedInstance().generate()
                obj.modelShippingMen?.id = HexGenerator.sharedInstance().generate()
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
    
    // MARK: Custom Delegate
    func getDataForFixedInvoices(dataDict: ModelInvoice) {
        //print(dataDict)
    }
    
    func getDataForInvoicePayments(dataDict: ModelInvoice) {
        
    }
    
    func getDataFromAddPayment(dataDict: ModelInvoice) {
        
        tempData = dataDict
        paymentItemsVC?.getDataForInvoicePayments(dataDict: tempData!)
        self.tableView.reloadData()
        self.saveData()
//        self.showAlert(title: "Message", message: "Click Complete Shipment/Payment button to complete this payment", closure: {})

    }
    func getDataFromShippingList(dataDict: ModelInvoice?){
        
        guard let dataDict = dataDict else{
            return
        }
        shippingItemsVC?.shippingList(shippingData: dataDict.shippingManifests)
        self.tableView.reloadData()
    }
    
    
    func saveData(){
        guard let tempData = tempData else {
            return
        }
        tempData.updated = true
        tempData.putBulkError = ""
        RealmManager().write(table: tempData)
        //Write timeStamp
        UtilWriteLogs.writeLog(timesStamp: UtilWriteLogs.curruntDate, event:activityLogEvent.Invoices.rawValue , objectId: tempData.id, lastSynch:nil)
        
        RealmManager().read(type: ModelInvoice.self, primaryKey: tempData.invoiceNumber!)
        
        let sigmodel = getModelSignature()
        if sigmodel.count > 0{
            
            //Create request for signature
            let arrayModelSignature = sigmodel
            let requestSignature = RequestSignature()
            var modelSign = ModelSignature()
            modelSign = arrayModelSignature[0]
            requestSignature.name = modelSign.name
            requestSignature.invoiceId = modelSign.invoiceId
            requestSignature.shippingMainfestId = modelSign.shippingMainfestId
            
            SKActivityIndicator.show()
            SyncService.sharedInstance().postInvoiceWithSignature(requestSignature: requestSignature, sigId: modelSign.id!) { (error : PlatformError?) in
                if error != nil{
                    SKActivityIndicator.dismiss()
                    self.showAlert(title: "Message", message: "Error while upload image", closure: {})
                }else{
                    SyncService.sharedInstance().callPostAPI(completion: { (error1 :PlatformError?) in
                        if error1 != nil{
                            SKActivityIndicator.dismiss()
                            self.showAlert(title: "Message", message: error1?.message ?? "Server error", closure: {})
                        }else{
                            SKActivityIndicator.dismiss()
                            SyncService.sharedInstance().syncData()
                            self.showAlert(title: "Message", message: "Submitted successfully", closure: {
                                 self.navigationController?.popViewController(animated: true)
                            })
                            
                        }
                    })
                    
                }
            }
        }else{
            SyncService.sharedInstance().callPostAPI(completion: { (error1 :PlatformError?) in
                if error1 != nil{
                    SKActivityIndicator.dismiss()
                    self.showAlert(title: "Message", message: error1?.message ?? "Server error", closure: {})
                }else{
                    SKActivityIndicator.dismiss()
                    SyncService.sharedInstance().syncData()
                    self.showAlert(title: "Message", message: "Submitted successfully", closure: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            })
        }
        //SyncService.sharedInstance().syncData()
        
    }
}

extension InvoiceDetailsTableViewController : newConfirmFinalProtocol{
    func confirmShip(objShip: ModelShipingMenifest) {
        print("in final vc")
        for obj in objShip.selectedItems {
            
            for product in (tempData?.remainingProducts)! {
                if obj.productId == product.productId {
                    product.remainingQuantity -= obj.requestQuantity
                }
            }
        }
        tempData?.shippingManifests.append(objShip)
        saveData()
//        self.showAlert(title: "Message", message: "Click Complete Shipment/Payment button to complete this Shipping manifest", closure: {})
    }

}


