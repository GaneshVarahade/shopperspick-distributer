//
//  QuantityAndBatchViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import KSToastView
import RealmSwift
import Realm

class QuantityAndBatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var tempDataDict = [[String:Any]]()
    var toolBar = UIToolbar()
    var doneButton = UIBarButtonItem()
    
    var batchPickerView : UIPickerView!
    
    //var modelInvoice: ModelInvoice!
    var shippingManifest : ModelShipingMenifest?
    var remainingItemList = List<ModelRemainingProduct>()
    
    var shippingMenifDelegate: ShippingMenifestSelectedItemsDelegate!
    var boolContinuePressed = false
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = NSLocalizedString("QtVcTitle", comment: "")
        itemsTableView.delegate     = self
        itemsTableView.dataSource   = self
        
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "< Add Product", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.back(sender:)))
//        self.navigationItem.leftBarButtonItem = newBackButton

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController, !boolContinuePressed {
            shippingManifest?.selectedItems.removeAll()
        }
    }
    
    
    // MARK:- UITableview Delegate/DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shippingManifest!.selectedItems.count
    }
    
    func getBatchSkuByProdId(prodId:String?) -> String{
        
        let ProductObj = RealmManager().readPredicate(type: ModelProduct.self, distinct: "productId", predicate:"productId = '\(prodId ?? "")'")
        if let Sku = ProductObj[0].sku{
            return Sku
        }else{
           return "--"
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuantityBatchTableViewCell
        let product = shippingManifest?.selectedItems[indexPath.row]
        
        cell.productLabel.text = product?.productName
        if let remainingQuantity = product?.remainingQuantity {
            cell.quantityTextField.text = "\(remainingQuantity)"
        }
        cell.batchTextField.text = getBatchSkuByProdId(prodId: product?.productId )
        //cell.batchTextField.text = product?.productId
        cell.batchTextField.tag = indexPath.row
        cell.quantityTextField.tag = indexPath.row
        
        cell.quantityTextField.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 170
        }
        else {
            return 140
        }
    }

    // MARK: - UIPickerView Delegate/Datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
 
    
    func didPressBatchBtn(_ tag: Int) {
        print("pressed \(tag)")
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {

        for product in (shippingManifest?.selectedItems)! {
  
            let index = shippingManifest?.selectedItems.map({ $0.productId }).index(of: product.productId)!

            let cell:QuantityBatchTableViewCell = itemsTableView.cellForRow(at: IndexPath.init(row: index!, section: 0)) as! QuantityBatchTableViewCell
             let requestQuantity = Double(cell.quantityTextField.text!)!
            
            let remainingProd = remainingItemList[index!]
            //print("\(product.requestQuantity) > \(remainingProd.remainingQuantity)")
            
            if requestQuantity > remainingProd.remainingQuantity {

                KSToastView.ks_showToast("\(NSLocalizedString("QtValidation", comment: "")) \(product.productName!)")
                //shippingManifest?.selectedItems.removeAll()
                return
            } else if requestQuantity <= 0 {
                KSToastView.ks_showToast("\(NSLocalizedString("QtValidation1", comment: "")) \(product.productName!)")
                //shippingManifest?.selectedItems.removeAll()
                return
            }
            product.requestQuantity = requestQuantity
        }
        
        boolContinuePressed = true
        shippingMenifDelegate.changeModelInvoice(shippingManifest: shippingManifest!)
        popBack(2)        
    }
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - (nb+1)], animated: true)
                return
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let cs = NSCharacterSet(charactersIn: "0123456789.").inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
    }

}
