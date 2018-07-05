//
//  Receive ShipmentViewController.swift
//  blaze
//
//  Created by Fidel iOS on 16/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
class Receive_ShipmentViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var productsView: UIView!
    var isTextFieldEmpty : Bool = false
    
    var modelPurchaseOrder: ModelPurchaseOrder!
    var selectedPurchaseOrder : [ModelPurchaseOrderProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.estimatedRowHeight = 120
        self.listTableView.rowHeight = UITableViewAutomaticDimension;
        self.title = "Received Products"
        //productsView.dropShadow()
    }
    
    //Mark : Btn Recive Shipment Clicked
    @IBAction func btnReciveShipmentClicked(_ sender: Any) {
        if selectedPurchaseOrder.count>0{
            var isValid : Bool = true
            for infoDict in selectedPurchaseOrder{
                if infoDict.validSelection == "No"{
                    isValid = false
                }
            }
            if isValid == true{
                for dict in selectedPurchaseOrder {
                    let modelpurchaseOrderProductRecive = ModelPurchaseOrderProductReceived()
                    modelpurchaseOrderProductRecive.name = dict.name
                    modelpurchaseOrderProductRecive.id = dict.id
                    modelpurchaseOrderProductRecive.expected = dict.quantity
                    modelpurchaseOrderProductRecive.received = dict.expected
                    modelPurchaseOrder.productReceived.append(modelpurchaseOrderProductRecive)
                }

                //Write to database
                modelPurchaseOrder.status = PurchaseOrderStatus.Closed.rawValue
                modelPurchaseOrder.updated = true
                RealmManager().write(table: modelPurchaseOrder)
//                print(RealmManager().readList(type: ModelPurchaseOrder.self))
//                print(RealmManager().read(type: ModelPurchaseOrder.self, primaryKey:modelPurchaseOrder.purchaseOrderNumber!))
                SyncService.sharedInstance().syncData()
                
                showAlert(alertTitle: "Done", alertMessage: "Saved Succesfully!",tag: 1)
                print(modelPurchaseOrder.productReceived)
            }else{
           showAlert(alertTitle: "Warning", alertMessage: "Recived product quantity should not be empty, and is always less than or equel to Expected product quantity ",tag: 0)
            }
        }else{
           showAlert(alertTitle: "Warning", alertMessage: "Please select product to save.",tag: 0)
        }
    }
    
    //Mark:- Alert View
    func showAlert(alertTitle:NSString,alertMessage:NSString,tag:Int) -> Void {
        let alert = UIAlertController(title: alertTitle as String, message: alertMessage as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                if tag == 1{
                    self.navigationController?.popViewControllers(controllersToPop: 2, animated: true)
                    
                }
                
            case .cancel:
                print("cancel")
                
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    //Text Field validation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()+_=")) == nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
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
        
        return cell
    }
    
   @objc func textFieldDidChange(_ textField: UITextField) {
        let index : Int = textField.tag
        print(index)
        if textField.text?.isEmpty == false{
        let expected : Double = (textField.text! as NSString).doubleValue
            if Int(expected) <= Int(modelPurchaseOrder.productInShipment[index].quantity){
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
        print(selectedPurchaseOrder);
    }
    
    //MARK:- BtnCountinue Clicked
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return string.rangeOfCharacter(from: CharacterSet.letters) == nil
//    }
}
