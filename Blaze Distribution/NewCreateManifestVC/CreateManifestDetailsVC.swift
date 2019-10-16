//
//  CreateManifestDetailsVC.swift
//  BLAZE Distribution
//
//  Created by Mac on 08/10/19.
//  Copyright © 2019 Fidel iOS. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import SKActivityIndicatorView

protocol newProtocolConfirmManifest {
    func newShippingManifest(objShip:ModelShipingMenifest)
}

class CreateManifestDetailsVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var manifestDetailsTable: UITableView!
    @IBOutlet weak var btnConfirmAll: UIButton!
    
    //Objects
    var modelInvoice: ModelInvoice!
    var modelShippingMenifest: ModelShipingMenifest!
    var invoiceSelectedItemList = List<ModelRemainingProduct>()
    var inventoryObject : ResponseGetAllInvetory!
    var batchObjectList : [Batchobject] = []
    var objproductMetrcInfoList = List<ModelProductMetrcInfo>()
    
    var confirmManifetsDetailDelegate : newProtocolConfirmManifest!
    
    //Onjcets
    var pickerView: UIPickerView = UIPickerView()
    let INVENTORYTEXTFIELD = 101
    let BATCHTEXTFIELD = 102
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
        self.getAllInventorise()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        
//        let requestObj = RequestGetallBatches()
//        requestObj.productId = "5d861945dc4f2a042097be64"
//        WebServicesAPI.sharedInstance().getAllBtachesByProdId(request: requestObj, onComplition: { (
//            response : ResponseGetAllBatches?, error : PlatformError?) in
//            print(response)
//            let keyArr : Array = response!.values!
//
//
//        })

        // Do any additional setup after loading the view.
    }
    
    func initialSetUp(){
        for item in invoiceSelectedItemList{
            let obj = ModelProductMetrcInfo()
            obj.id = HexGenerator.sharedInstance().generate()
            obj.productId = item.productId
            obj.orderItemId = item.orderItemId
            objproductMetrcInfoList.append(obj)
        }
    }
    
    func getAllInventorise(){
        //This is tempcall
        let onjrequest = RequestGetAllInventory()
        SKActivityIndicator.show()
        WebServicesAPI.sharedInstance().getAllInventory(request: onjrequest) {
            (response : ResponseGetAllInvetory?,error : PlatformError?) in
            SKActivityIndicator.dismiss()
            if error == nil{
                self.inventoryObject = response
            }
        }
    }
    
    func fetchBatcList(productId : String, invID : String){

                self.batchObjectList.removeAll()
                let requestObj = RequestGetallBatches()
                requestObj.productId = productId
                SKActivityIndicator.show()
                WebServicesAPI.sharedInstance().getAllBtachesByProdId(request: requestObj, onComplition: { (
                    response : ResponseGetAllBatches?, error : PlatformError?) in
//                    print(response)
//                    let keyArr : Array = response!.values!
                    SKActivityIndicator.dismiss()
                    if error == nil{
                        if let arrValue = response!.values{
                            for itemBatch in arrValue{
                               let mapobject = itemBatch.batchQuantityMap
                                if mapobject != nil{
                                    let key = mapobject?.keys
                                    if key!.count > 0{
                                        for item in key!{
                                            if item == invID{
                                            let invqty = mapobject?[item]
                                            if invqty! > 0{
                                                let objbatch = Batchobject()
                                                objbatch.batchId = itemBatch.id
                                                objbatch.batchSku = itemBatch.sku
                                                objbatch.inventoryQty = Double(invqty!)
                                                objbatch.orderInventoryId = item
                                                let qty = "\( Double(invqty!))"
                                                let batchDate = DateFormatterUtil.format(dateTime: Double(itemBatch.created! / 1000), format: DateFormatterUtil.mmddyyyy)
                                                objbatch.batchDate = "\(itemBatch.sku ?? "") - \(qty)"
                                                self.batchObjectList.append(objbatch)
                                                
                                            }
                                          }
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    self.pickerView.reloadAllComponents()
             })
        
        
    }
    //MARK:- PickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == INVENTORYTEXTFIELD{
           return self.inventoryObject.values?.count ?? 0
        }else{
           return self.batchObjectList.count ?? 0
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         if pickerView.tag == INVENTORYTEXTFIELD{
              return self.inventoryObject.values![row].name
         }else{
              return self.batchObjectList[row].batchDate
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- Textfield delegate
    @objc func InventoryPickerButtonTapped(_ sender : MyCustomTextField){
        let tag = sender.section
        let invobj = invoiceSelectedItemList[tag!]
        let selectedInvObj = inventoryObject.values![pickerView.selectedRow(inComponent: 0)]
        invobj.SelectedInventoryName = selectedInvObj.name
        invobj.SelectedInventoryId = selectedInvObj.id
        invobj.SelectedBatchName = ""
        invobj.SelectedBatchId = ""
        manifestDetailsTable.reloadData()
    
    }
    @objc func BatchPickerButtonTapped(_ sender : MyCustomTextField){
        if batchObjectList.count > 0{
        let tag = sender.section
        let invobj = invoiceSelectedItemList[tag!]
        let selectedBatch = batchObjectList[pickerView.selectedRow(inComponent: 0)]
        invobj.SelectedBatchName = selectedBatch.batchDate
        invobj.SelectedBatchId = selectedBatch.batchId
        invobj.SelectedBatchSKU = selectedBatch.batchSku
        invobj.SelectedBatchQty = selectedBatch.inventoryQty!
        manifestDetailsTable.reloadData()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        let textF = textField as! MyCustomTextField
        if textF.tag == INVENTORYTEXTFIELD{
            //for inventory textfield
            pickerView.tag = INVENTORYTEXTFIELD
            pickerView.reloadAllComponents()
            return true
        }else if textF.tag == BATCHTEXTFIELD{
            //call batch API
            pickerView.tag = BATCHTEXTFIELD
            var productId = ""
            let section = textF.section
            productId = invoiceSelectedItemList[section!].productId ?? ""
            
            //get selected inventory id
            let selectedInventoryId = invoiceSelectedItemList[textF.section!].SelectedInventoryId
            if selectedInventoryId == ""{
                self.showAlert(title: "Distribution", message: "Please select inventory first", closure: {})
                return false
            }else{
               self.fetchBatcList(productId: productId, invID: selectedInventoryId ?? "")
            }

            return true
        }else{
            return true
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//       if textField.tag != INVENTORYTEXTFIELD && textField.tag != BATCHTEXTFIELD{
//         if textField.text == ""{
//            return true
//          }
////            let cs = NSCharacterSet(charactersIn: "0123456789.").inverted
////            let filtered = string.components(separatedBy: cs).joined(separator: "")
////            return (string == filtered)
//            return   self.isValidAmount(textfield: textField as! MyCustomTextField)
//        }
        return true
    }
    
    func isValidAmount(textfield : MyCustomTextField) -> Bool{
        let userenteredQty = Double(textfield.text!)
        let section = textfield.section
        let row = textfield.row!
        
        //get product total selected Qty
        var ProductRequestQty : Double = 0
        let objMetricinfo = invoiceSelectedItemList[section!]
        ProductRequestQty = objMetricinfo.remainingQuantity
        
        var batchActualQty : Double = 0
        let listmetr = objproductMetrcInfoList[section!].batchDetailsList[row]
        batchActualQty = listmetr.BatchActualQty
        
        if Int(userenteredQty!) <= Int(ProductRequestQty) && Int(userenteredQty!) <= Int(batchActualQty){
            listmetr.UserEnterQty = userenteredQty!
            return true
        }else{
            return false
        }
       
    }
    
    
    //MARK:- Button Actions
    @IBAction func btnSaveItemTapped(_ sender: myCustombutton) {
        self.showAlert(title: "Message", message:"Please make sure this quantity is final for this Invenotry and Batch, once save its not editable", actions:[UIAlertActionStyle.cancel,UIAlertActionStyle.default], closure:{ action in
            switch action {
            case .default :
                
               //Save line items
                let section = sender.section!
                let row = sender.row!
                var userEnterQty : Int = 0
                var qtyInCart : Int = 0
                var actualBatchQty : Int = 0
                var batchfinalQty : Int = 0
                
                var actualorederQty : Int = 0
                
                let objMetricInfo = self.objproductMetrcInfoList[section]
                let itemObject = objMetricInfo.batchDetailsList[row]
                var objReaminProd = self.invoiceSelectedItemList[section]
                
                actualorederQty = Int(objReaminProd.remainingQuantity)
                
                qtyInCart = Int(objMetricInfo.quantity)
                userEnterQty = Int(itemObject.UserEnterQty)
                actualBatchQty = Int(itemObject.BatchActualQty)
                batchfinalQty = Int(itemObject.quantity)
                
                if userEnterQty != 0{
                    actualorederQty = actualorederQty - userEnterQty
                    
                    actualBatchQty = actualBatchQty - userEnterQty
                    qtyInCart = qtyInCart + userEnterQty
                    batchfinalQty = batchfinalQty + userEnterQty
                    
                    objMetricInfo.quantity = Double(qtyInCart)
                    itemObject.quantity = Double(batchfinalQty)
                    itemObject.BatchActualQty = Double(actualBatchQty)
                    objReaminProd.remainingQuantity = Double(actualorederQty)
                    itemObject.isSaved = true
                    self.manifestDetailsTable.reloadData()
                    
                }else{
                    self.showAlert(title: "Message", message: "Please enter valid quantity to save this item", closure: {})
                }
                
                
            case .cancel :
                print("cancel")
                
            case .destructive :
                print("Destructive")
            }
            
        })
        
    }
    
    func canconfirmmanifest()->Bool{
        for item in objproductMetrcInfoList{
            if item.batchDetailsList.count > 0{
                return true
            }
        }
        return false
    }
    
    @IBAction func btnConfirmAllTapped(_ sender: Any) {
        if canconfirmmanifest(){
            if isalllineitemsaved(){
                self.showAlert(title: "Message", message:"Are you sure you want to finalize the shipping manifest, It can't be edited after that?", actions:[UIAlertActionStyle.cancel,UIAlertActionStyle.default], closure:{ action in
                    switch action {
                    case .default :
                        print("default")
                        print(self.modelShippingMenifest)
                        self.modelShippingMenifest.updated = true
                        self.modelShippingMenifest.productMetrcInfoList = self.objproductMetrcInfoList
                        self.confirmManifetsDetailDelegate.newShippingManifest(objShip: self.modelShippingMenifest)
                        
                            for controller in self.navigationController!.viewControllers{
                                                        if controller.isKind(of: InvoiceDetailsTableViewController.self){
                                                            self.navigationController!.popToViewController(controller, animated: true)
                                                    }
                                            }
                        
                    case .cancel :
                        print("cancel")
                        
                    case .destructive :
                        print("Destructive")
                    }
                    
                })
                
            }else{
                self.showAlert(title: "Message", message: "Please make sure you saved all added product", closure: {})
            }

        }else{
            self.showAlert(title: "Message", message: "No batches added, please add batch to proceed further", closure:{})
        } 
    }
    
    func isalllineitemsaved()->Bool{
        var saved = true
        for item in objproductMetrcInfoList{
            for obj in item.batchDetailsList{
                if obj.isSaved == false{
                    saved = false
                }
            }
        }
        
        return saved
    }
    
    @IBAction func btnaddBatchTapped(_ sender: Any) {
        let button = sender as! UIButton
        if validateBatchandInv(tag: button.tag){
            var remainingProdInfoObj = invoiceSelectedItemList[button.tag]
            if Int(remainingProdInfoObj.remainingQuantity) != 0{
                if self.isSameBatchAndInventory(tag: button.tag){
            for item in objproductMetrcInfoList{
                if item.productId == remainingProdInfoObj.productId{
                    let objBatchDetails = ModelBatchDetails()
                    objBatchDetails.batchId = remainingProdInfoObj.SelectedBatchId
                    objBatchDetails.batchSku = remainingProdInfoObj.SelectedBatchSKU
                    objBatchDetails.BatchActualQty = remainingProdInfoObj.SelectedBatchQty
                    objBatchDetails.overrideInventoryId = remainingProdInfoObj.SelectedInventoryId
                    objBatchDetails.SelectedBatchName = remainingProdInfoObj.SelectedBatchName
                    objBatchDetails.SelectedInvName = remainingProdInfoObj.SelectedInventoryName
                    item.batchDetailsList.append(objBatchDetails)
                }
            }
            manifestDetailsTable.reloadData()
                }else{
                    self.showAlert(title: "Message", message: "Same record is previously added, please select diffrent batch", closure: {})
                }
                    
            }
             else{
                self.showAlert(title: "Message", message: "No remaining qty found for product", closure: {})
            }
            
        }else{
            self.showAlert(title: "Message", message: "Please select inventory and batch", closure: {})
        }
        
    }
    
    func isSameBatchAndInventory(tag : Int) -> Bool{
        let obj = invoiceSelectedItemList[tag]
        let selectedInvId = obj.SelectedInventoryId
        let selectedBatchId = obj.SelectedBatchId

        let objprodmetric = objproductMetrcInfoList[tag]
        let list = objprodmetric.batchDetailsList
        if list.count == 0{
            return true
        }else{
            
            for item in list{
                if item.overrideInventoryId == selectedInvId && item.batchId  == selectedBatchId{
                   return false
                }
                
            }
        }
        
        return true
    }
    
    func validateBatchandInv(tag : Int) -> Bool{
        let obj = invoiceSelectedItemList[tag]
        if obj.SelectedInventoryId != "" && obj.SelectedBatchId != ""{
            return true
        }
        return false
    }
    
    @IBAction func textChange(_ sender: MyCustomTextField) {
        if sender.text != ""{
        if !self.isValidAmount(textfield: sender){
           sender.text = ""
        }
    }
  }

}

extension CreateManifestDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return invoiceSelectedItemList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objproductMetrcInfoList[section].batchDetailsList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let prodHeaderCell = self.manifestDetailsTable.dequeueReusableCell(withIdentifier: "SMHeaderProductCell") as! SMHeaderProductCell
             let remainigItem = invoiceSelectedItemList[indexPath.section]
            //Tags
            prodHeaderCell.btnAdd.tag = indexPath.section

            //Data
            prodHeaderCell.lblProductName.text = remainigItem.productName
            prodHeaderCell.lblOrderedQty.text = "\(remainigItem.requestQuantity)"
            prodHeaderCell.lblRemainingQty.text = "\(remainigItem.remainingQuantity)"
            prodHeaderCell.txtSelectBatch.text = "\(remainigItem.SelectedBatchName ?? "")"
            prodHeaderCell.txtSelectInventory.text = "\(remainigItem.SelectedInventoryName ?? "")"
            
            prodHeaderCell.txtSelectBatch.delegate = self
            prodHeaderCell.txtSelectInventory.delegate = self
            
            prodHeaderCell.txtSelectInventory.inputView = pickerView
            prodHeaderCell.txtSelectInventory.section = indexPath.section
            prodHeaderCell.txtSelectInventory.keyboardToolbar.doneBarButton.setTarget(self, action:#selector(InventoryPickerButtonTapped(_:)))

            prodHeaderCell.txtSelectBatch.inputView = pickerView
            prodHeaderCell.txtSelectBatch.section = indexPath.section
            prodHeaderCell.txtSelectBatch.keyboardToolbar.doneBarButton.setTarget(self, action:#selector(BatchPickerButtonTapped(_:)))
           
            prodHeaderCell.setUI()
            return prodHeaderCell
        }else{
            let prodHeaderDetailCell = self.manifestDetailsTable.dequeueReusableCell(withIdentifier: "SMDetaildProductCell") as! SMDetaildProductCell
            prodHeaderDetailCell.txtActualQty.row = indexPath.row - 1
            prodHeaderDetailCell.txtActualQty.section = indexPath.section
            prodHeaderDetailCell.btnSaveItem.section = indexPath.section
            prodHeaderDetailCell.btnSaveItem.row = indexPath.row - 1
            
            //set data
            let objbatchDetailList = objproductMetrcInfoList[indexPath.section].batchDetailsList
            prodHeaderDetailCell.lblBatchName.text = objbatchDetailList[indexPath.row - 1].SelectedBatchName
            prodHeaderDetailCell.lblInventoryName.text = objbatchDetailList[indexPath.row - 1].SelectedInvName
            prodHeaderDetailCell.lblAvailabelBatchQty.text = "\(objbatchDetailList[indexPath.row - 1].BatchActualQty)"
            prodHeaderDetailCell.txtActualQty.text = "\(objbatchDetailList[indexPath.row - 1].UserEnterQty)"
            prodHeaderDetailCell.setupUI()
        
            //hide show cell
            prodHeaderDetailCell.isUserInteractionEnabled = true
            prodHeaderDetailCell.containtView.alpha = 1.0
            if objbatchDetailList[indexPath.row - 1].isSaved{
                prodHeaderDetailCell.isUserInteractionEnabled = false
                prodHeaderDetailCell.containtView.alpha = 0.4
            }
            
            return prodHeaderDetailCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}

class MyCustomTextField : UITextField {
    var row : Int?
    var section : Int?
}

class Batchobject {
    var batchId : String?
    var orderInventoryId : String?
    var inventoryQty : Double?
    var batchDate : String?
    var batchSku : String?
}

class myCustombutton : UIButton{
    var row : Int?
    var section : Int?
}
