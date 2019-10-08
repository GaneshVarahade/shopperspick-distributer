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
    var batchObjectList : [Batchobject]!
    
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
    
    func fetchBatcList(productId : String, invID : String) -> [Batchobject]{
        self.batchObjectList.removeAll()
                let requestObj = RequestGetallBatches()
                requestObj.productId = productId
                WebServicesAPI.sharedInstance().getAllBtachesByProdId(request: requestObj, onComplition: { (
                    response : ResponseGetAllBatches?, error : PlatformError?) in
//                    print(response)
//                    let keyArr : Array = response!.values!
                    if error == nil{
                        if let arrValue = response!.values{
                            for item in arrValue{
                                let invMap = item
                                
                            }
                            
                        }
                    }
             })
        
        return batchObjectList
    }
    //MARK:- PickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.inventoryObject.values?.count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.inventoryObject.values![row].name
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
    @objc func InventoryPickerButtonTapped(){
        
    }
    @objc func BatchPickerButtonTapped(){
        
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
            
            return false
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
        return 1
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
            prodHeaderCell.txtSelectInventory.keyboardToolbar.doneBarButton.setTarget(self, action:#selector(InventoryPickerButtonTapped))

            prodHeaderCell.txtSelectBatch.inputView = pickerView
            prodHeaderCell.txtSelectBatch.section = indexPath.section
            prodHeaderCell.txtSelectBatch.keyboardToolbar.doneBarButton.setTarget(self, action:#selector(BatchPickerButtonTapped))
           
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
