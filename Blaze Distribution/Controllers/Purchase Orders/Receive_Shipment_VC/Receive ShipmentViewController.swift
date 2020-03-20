//
//  Receive ShipmentViewController.swift
//  blaze
//
//  Created by Fidel iOS on 16/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
import CZPicker
class Receive_ShipmentViewController: UIViewController,UITextFieldDelegate,ReceiveShipmentDelegate {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var productsView: UIView!
    var isTextFieldEmpty : Bool = false
    
    var modelPurchaseOrder: ModelPurchaseOrder!
    var selectedPurchaseOrder : [ModelPurchaseOrderProduct] = []
    let pickerView: CZPickerView = CZPickerView(headerTitle: "Select Batch Status", cancelButtonTitle: "Cancel", confirmButtonTitle: "Select")
    
    let batchStatus = ["In Testing", "Received", "Ready For Sale"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.estimatedRowHeight = 120
        self.listTableView.rowHeight = UITableViewAutomaticDimension;
        self.title = NSLocalizedString("ReceiveShipTitle", comment: "")
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.needFooterView = true
        pickerView.headerBackgroundColor = UIColor.APPGreenColor
        pickerView.confirmButtonBackgroundColor = UIColor.APPGreenColor
        pickerView.checkmarkColor = UIColor.APPGreenColor
        //productsView.dropShadow()
    }
    
    //Mark : Btn Recive Shipment Clicked
    @IBAction func btnReciveShipmentClicked(_ sender: Any) {
        
        guard selectedPurchaseOrder.count>0 else{
            showAlert(title: NSLocalizedString("Warning", comment: ""), message: "Please select product to save.", closure: {})
            return
        }
        
        var isValid : Bool = true
        for infoDict in selectedPurchaseOrder{
            if infoDict.validSelection == "No"{
                isValid = false
            }
        }
        
        guard isValid else {
            showAlert(title: NSLocalizedString("Warning", comment: ""), message: "Received product quantity should not be empty, and is always less than or equal to expected product quantity ", closure: {})
            return
        }
        for dict in modelPurchaseOrder.productInShipment {
            let modelpurchaseOrderProductRecive = ModelPurchaseOrderProductReceived()
            modelpurchaseOrderProductRecive.name = dict.name
            modelpurchaseOrderProductRecive.productId = dict.productId
            modelpurchaseOrderProductRecive.id = dict.id
            modelpurchaseOrderProductRecive.expected = dict.quantity
            
            for selectedDict in selectedPurchaseOrder{
                if selectedDict.productId == dict.productId{
                    modelpurchaseOrderProductRecive.received = dict.expected
                    guard dict.receiveBatchStatus != nil else {
                        displayWarningMessage()
                        modelPurchaseOrder.productReceived.removeAll()
                        return
                    }
                    break
                }else{
                    modelpurchaseOrderProductRecive.received = 0
                }
            }
            
            modelpurchaseOrderProductRecive.totalCost = dict.totalCost
            modelpurchaseOrderProductRecive.unitPrice = dict.unitPrice
            
            modelpurchaseOrderProductRecive.discount = dict.discount
            modelpurchaseOrderProductRecive.exciseTax = dict.exciseTax
            modelpurchaseOrderProductRecive.totalExciseTax = dict.totalExciseTax
            modelpurchaseOrderProductRecive.totalCultivationTax = dict.totalCultivationTax
            modelpurchaseOrderProductRecive.receiveBatchStatus = dict.receiveBatchStatus
            
            modelPurchaseOrder.productReceived.append(modelpurchaseOrderProductRecive)
        }
        
        //Write to database
        modelPurchaseOrder.status = PurchaseOrderStatus.Closed.rawValue
        modelPurchaseOrder.updated = true
        RealmManager().write(table: modelPurchaseOrder)
        //SyncService.sharedInstance().syncData()
        
        SKActivityIndicator.show()
        SyncService.sharedInstance().callPostAPI { (error : PlatformError?) in
            if error != nil{
                SKActivityIndicator.dismiss()
                self.showAlert(title: "Message", message: error?.message ?? NSLocalizedString("ServerError", comment: ""), closure:{})
                
            }else{
                //write Logs
                //write log
                SKActivityIndicator.dismiss()
                UtilWriteLogs.writeLog(timesStamp: UtilWriteLogs.curruntDate, event:activityLogEvent.PurchaseOrderes.rawValue , objectId: self.modelPurchaseOrder.id, lastSynch:nil)
                
                self.showAlert(title: NSLocalizedString("Done", comment: ""), message: NSLocalizedString("Saved Successfully!", comment: ""), closure: {
                    SyncService.sharedInstance().syncData()
                    self.navigationController?.popViewControllers(controllersToPop: 2, animated: true)
                })
                
            }
        }
    
        //print(modelPurchaseOrder.productReceived)
    }
    //Text Field validation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: "0123456789.").inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        return (string == filtered)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func displayWarningMessage(){
        let alert = UIAlertController(title: "Warning", message: "Please set a valid batch status for all products", preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okay)
        
        present(alert, animated: true, completion: nil)
    }
}

extension Receive_ShipmentViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return modelPurchaseOrder.productReceived.count + 1
        return modelPurchaseOrder.productInShipment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  listTableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! ReceiveShipmentTableViewCell
        cell.delegate = self
        //var productInShipMent
        cell.lblProduct?.text = modelPurchaseOrder.productInShipment[indexPath.row].name
        cell.lblExpected?.text = String(format: "%0.1f",modelPurchaseOrder.productInShipment[indexPath.row].quantity)
        cell.txtRecived.text = String(format: "%0.1f",modelPurchaseOrder.productInShipment[indexPath.row].expected)
        
        //Check Box
        cell.btnCheck.addTarget(self, action: #selector(checkboxClicked(_ :)), for: .touchUpInside)
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.setImage(UIImage(named : "checkbox_unselected"), for: UIControlState.normal)
        cell.btnCheck.setImage(UIImage(named : "Checkbox"), for: UIControlState.selected)
        
        //text field
        cell.txtRecived.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: UIControlEvents.editingChanged)
        cell.txtRecived.tag = indexPath.row
        cell.txtRecived.delegate=self
        if self.modelPurchaseOrder.productInShipment[indexPath.row].validSelection == "Yes" || self.modelPurchaseOrder.productInShipment[indexPath.row].validSelection == ""{
            cell.txtRecived.layer.borderWidth=0.0
            cell.txtRecived.layer.borderColor = (UIColor .clear).cgColor
        }else{
            cell.txtRecived.layer.borderWidth=0.7
            cell.txtRecived.layer.borderColor = (UIColor .red).cgColor
            cell.txtRecived.text=""
        }
        
        cell.btnBatchStatus.tag = indexPath.row
        
        var receivedBatchStatus = "Select Batch Status"
        
        let batchIndex = getCurrentBatch(indexPath.row)
        
        if batchIndex > -1{
            receivedBatchStatus = batchStatus[batchIndex]
        }
        
        cell.btnBatchStatus.setTitle(receivedBatchStatus, for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   @objc func textFieldDidChange(_ textField: UITextField) {
        let index : Int = textField.tag
        print(index)
        if textField.text?.isEmpty == false{
        let expected : Double = (textField.text! as NSString).doubleValue
            if expected <= Double(modelPurchaseOrder.productInShipment[index].quantity){
                textField.layer.borderWidth=0.0
                textField.layer.borderColor = (UIColor .clear).cgColor
                
                self.modelPurchaseOrder.productInShipment[index].expected = expected
                self.modelPurchaseOrder.productInShipment[index].validSelection = "Yes"
                //check whether object was selected or not
                if selectedPurchaseOrder.contains(self.modelPurchaseOrder.productInShipment[index]){
                    selectedPurchaseOrder = selectedPurchaseOrder.filter { $0 != self.modelPurchaseOrder.productInShipment[index] }
                    //add object
                    selectedPurchaseOrder.append(self.modelPurchaseOrder.productInShipment[index])
                }
                print(textField.text ?? "")
                print(selectedPurchaseOrder);
            }else{
                textField.layer.borderWidth=0.7
                textField.layer.borderColor = (UIColor .red).cgColor
                self.modelPurchaseOrder.productInShipment[index].validSelection = "No"
                //check whether object was selected or not
                if selectedPurchaseOrder.contains(self.modelPurchaseOrder.productInShipment[index]){
                    selectedPurchaseOrder = selectedPurchaseOrder.filter { $0 != self.modelPurchaseOrder.productInShipment[index] }
                    //add object
                    selectedPurchaseOrder.append(self.modelPurchaseOrder.productInShipment[index])
                }
               //showAlert(alertTitle: "Warning", alertMessage: "Recived Quantity should be equel to or less than expected",tag: 0)
            }
       }else{
            textField.layer.borderWidth=0.7
            textField.layer.borderColor = (UIColor .red).cgColor
            self.modelPurchaseOrder.productInShipment[index].validSelection = "No"
            //check whether object was selected or not
            if selectedPurchaseOrder.contains(self.modelPurchaseOrder.productInShipment[index]){
                selectedPurchaseOrder = selectedPurchaseOrder.filter { $0 != self.modelPurchaseOrder.productInShipment[index] }
                //add object
                selectedPurchaseOrder.append(self.modelPurchaseOrder.productInShipment[index])
            }
        //textField.text = String(format: "%0.1f",modelPurchaseOrder.productInShipment[index].quantity)
        //showAlert(alertTitle: "Warning", alertMessage: "Recived Quantity should not be empty",tag: 0)
    }
}
    
    @objc func checkboxClicked(_ sender: UIButton) {
        let index : Int = sender.tag
        print(index)
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            selectedPurchaseOrder.append(self.modelPurchaseOrder.productInShipment[index])
        }else{
            selectedPurchaseOrder = selectedPurchaseOrder.filter { $0 != self.modelPurchaseOrder.productInShipment[index] }
        }
        //print(selectedPurchaseOrder);
    }
    
    func onBatchStatusClicked(_ sender: Any) {
        pickerView.tag = (sender as! UIButton).tag
        var batchIndex = getCurrentBatch(pickerView.tag)
        batchIndex = batchIndex > -1 ? batchIndex : 1
//        if getCurrentBatch(pickerView.tag) > -1 && !modelPurchaseOrder.productInShipment[pickerView.tag].batchStatusModified{
//            showToast("Batch has been accepted!")
//            return
//        }
        pickerView.setSelectedRows([NSNumber(value: batchIndex)])
        pickerView.show()
    }
    
    func getCurrentBatch(_ index:Int)-> Int{
        if let receivedBatchStatus = modelPurchaseOrder.productInShipment[index].receiveBatchStatus {
        switch receivedBatchStatus {
        case BatchStatus.IN_TESTING.rawValue:
            return 0
        case BatchStatus.RECEIVED.rawValue:
            return 1
        default:
            return 2
        }
        }
        return -1
    }
    //MARK:- BtnCountinue Clicked
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return string.rangeOfCharacter(from: CharacterSet.letters) == nil
//    }
}

extension Receive_ShipmentViewController:CZPickerViewDelegate, CZPickerViewDataSource{
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return BatchStatus.allCases.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return batchStatus[row]
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        modelPurchaseOrder.productInShipment[pickerView.tag].receiveBatchStatus = BatchStatus.allCases[row].rawValue
        modelPurchaseOrder.productInShipment[pickerView.tag].batchStatusModified = true
        listTableView.reloadData()
    }
}
