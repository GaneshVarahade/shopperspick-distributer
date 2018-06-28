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
    
    var modelPurchaseOrder: ModelPurchaseOrder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.estimatedRowHeight = 120
        self.listTableView.rowHeight = UITableViewAutomaticDimension;
        self.title = "Received Products"
        //productsView.dropShadow()
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
        
        //Check Box
        cell.btnCheck.addTarget(self, action: #selector(checkboxClicked(_ :)), for: .touchUpInside)
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.setImage(UIImage(named : "checkbox_unselected"), for: UIControlState.normal)
        cell.btnCheck.setImage(UIImage(named : "Checkbox"), for: UIControlState.selected)
        
        //text field
        cell.txtRecived.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: UIControlEvents.editingChanged)
        cell.txtRecived.tag = indexPath.row
        
        return cell
    }
    
   @objc func textFieldDidChange(_ textField: UITextField) {
        let index : Int = textField.tag
        print(index)
        print(textField.text ?? "")
        //your code
    }
    
    @objc func checkboxClicked(_ sender: UIButton) {
        let index : Int = sender.tag
        print(index)
        sender.isSelected = !sender.isSelected
    }
    
    //Mark:- Button Acton
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
//            //table add btn clicked
//            let vc = storyboard?.instantiateViewController(withIdentifier: "PurchaseOrderAddShipment") as! PurchaseOrderAddShipment_VC
//            navigationController?.pushViewController(vc, animated: true)
//            
//        }
//    }
    
}
