//
//  LookUpProductEnterQuantity.swift
//  Blaze Distribution
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit

class LookUpProductEnterQuantity: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var lblBatchName: UILabel!
    var selecetdProduct = [ModelProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Enter Quantity"
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Basket"), style: .done, target: self, action: #selector(basketBtnPressed))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        setInitialValue()
        
        
        //Adda tap gesture to view
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickFromStore)))
        
    }
    
    //MARK: - Helper

    @objc private func onclickFromStore() {
    self.view.endEditing(true)
    }
    func setInitialValue() {
        self.lblProductName?.text = selecetdProduct[0].name ?? ""
        self.lblBatchName?.text = selecetdProduct[0].id ?? ""
        self.txtQuantity.text = String(format:"%.1f",selecetdProduct[0].quantity)
        
    }
    // MARK: - Selector methods
    @objc func basketBtnPressed() {
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasketViewController")
        self.navigationController?.pushViewController(obj, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Text Field Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()+_=")) == nil
    }
    
    //MARK: - Button Action
    @IBAction func btnAddToBasketClicked(_ sender: Any) {
        //save data into cart
        if txtQuantity.text?.isEmpty == true {
            showToast("Please enter product quantity to proceed further")
        }else{
            let modelCartProduct = ModelCartProduct()
            modelCartProduct.name = selecetdProduct[0].name ?? ""
            modelCartProduct.batchId = selecetdProduct[0].id ?? ""
            let quantity = Double(txtQuantity.text!)
            modelCartProduct.quantity = quantity!
            
            //Write data to database
            //        modelPurchaseOrder.status = PurchaseOrderStatus.Closed.rawValue
            //        modelPurchaseOrder.updated = true
            RealmManager().write(table: modelCartProduct)
            showToast("Added in Cart")
            self.navigationController?.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
