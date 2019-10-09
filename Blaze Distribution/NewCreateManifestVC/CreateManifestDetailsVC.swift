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

class CreateManifestDetailsVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var manifestDetailsTable: UITableView!
    @IBOutlet weak var btnConfirmAll: UIButton!
    
    //Objects
    var modelInvoice: ModelInvoice!
    var modelShippingMenifest: ModelShipingMenifest!
    var invoiceSelectedItemList = List<ModelRemainingProduct>()
    var inventoryObject : ResponseGetAllInvetory!
    var batchObjectList : [Batchobject] = []
    
    //Onjcets
    var pickerView: UIPickerView = UIPickerView()
    let INVENTORYTEXTFIELD = 101
    let BATCHTEXTFIELD = 102
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                                            let invqty = mapobject?[item]
                                            if invqty! > 0{
                                                let objbatch = Batchobject()
                                                objbatch.batchId = itemBatch.id
                                                objbatch.batchSku = itemBatch.sku
                                                objbatch.inventoryQty = Double(invqty!)
                                                objbatch.orderInventoryId = item
                                                let batchDate = DateFormatterUtil.format(dateTime: Double(itemBatch.created! / 1000), format: DateFormatterUtil.mmddyyyy)
                                                objbatch.batchDate = "\(itemBatch.sku ?? "")-\(batchDate)"
                                                self.batchObjectList.append(objbatch)
                                                
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
        
        
    }
    @objc func BatchPickerButtonTapped(_ sender : MyCustomTextField){
        let tag = sender.section
        
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
            
            var selectedInventoryId = "5d52826cdc4f2a7d6e0a22fc"
            self.fetchBatcList(productId: productId, invID: selectedInventoryId)
            
            return true
        }else{
            return true
        }
    }
    
    //MARK:- Button Actions
    @IBAction func btnConfirmAllTapped(_ sender: Any) {
    }
    @IBAction func btnaddBatchTapped(_ sender: Any) {
    }
    
}

extension CreateManifestDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return invoiceSelectedItemList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let prodHeaderCell = self.manifestDetailsTable.dequeueReusableCell(withIdentifier: "SMHeaderProductCell") as! SMHeaderProductCell
             let remainigItem = invoiceSelectedItemList[indexPath.section]
            //Tags

            //Data
            prodHeaderCell.lblProductName.text = remainigItem.productName
            prodHeaderCell.lblOrderedQty.text = "\(remainigItem.requestQuantity)"
            prodHeaderCell.lblRemainingQty.text = "\(remainigItem.remainingQuantity)"
            
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
            prodHeaderDetailCell.txtActualQty.row = indexPath.row
            prodHeaderDetailCell.txtActualQty.section = indexPath.section
            prodHeaderDetailCell.setupUI()
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
