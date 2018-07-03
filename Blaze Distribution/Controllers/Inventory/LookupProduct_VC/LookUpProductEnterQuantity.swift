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
    var isFromScanView : Bool = false
    var modelProudct: ModelProduct!
    var modelCreateTransfer:ModelCreateTransfer!
    let customBarbutton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Enter Quantity"
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        //let button = UIButton(type: .system)
        customBarbutton.setBackgroundImage(UIImage(named: "Basket"), for: (UIControlState.normal))
        customBarbutton.setTitle("12", for: UIControlState.normal)
        customBarbutton.setTitleColor(UIColor.white, for: UIControlState.normal)
        customBarbutton.sizeToFit()
        customBarbutton.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        customBarbutton.addTarget(self, action: #selector(basketBtnPressed), for: UIControlEvents.touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: customBarbutton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        setInitialValue()
        //Adda tap gesture to view
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickFromStore)))
        
    }
    
    //MARK: - Helper
    @objc private func onclickFromStore() {
    self.view.endEditing(true)
    }

    
    func setInitialValue() {
        //set cart count
        customBarbutton.setTitle(String(modelCreateTransfer.slectedProducts.count), for: UIControlState.normal)
        
        //set product model value
        self.lblProductName?.text = modelProudct.name
        self.lblBatchName?.text = modelProudct.id
        self.txtQuantity.text = String(format:"%.1f",modelProudct.quantity)
    }
    
    // MARK: - Selector methods
    @objc func basketBtnPressed() {
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
        obj.modelCreateTrasfer = self.modelCreateTransfer
        self.navigationController?.pushViewController(obj, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Text Field Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()+_= ")) == nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
        
    
    //MARK: - Button Action
    @IBAction func btnAddToBasketClicked(_ sender: Any) {
        //save data into cart
        if txtQuantity.text?.isEmpty == true {
            showToast("Please enter product quantity to proceed further")
        }else{
            let modelCartProduct = ModelCartProduct()
            modelCartProduct.name = modelProudct.name
            modelCartProduct.batchId = modelProudct.id
            let quantity = Double(txtQuantity.text!)
            modelCartProduct.quantity = quantity!
            modelCreateTransfer.slectedProducts.append(modelCartProduct)
            showToast("Added in Cart")
            
            //set cart count
            customBarbutton.setTitle(String(modelCreateTransfer.slectedProducts.count), for: UIControlState.normal)
            self.navigationController?.popViewController(animated: true)
//            if isFromScanView == false {
//                self.navigationController?.popViewController(animated: true)
//            }
       
//            let modelpurchaseOrderProductRecive = ModelPurchaseOrderProductReceived()
//            modelpurchaseOrderProductRecive.name = dict.name
//            modelpurchaseOrderProductRecive.id = dict.id
//            modelpurchaseOrderProductRecive.expected = dict.quantity
//            modelpurchaseOrderProductRecive.received = dict.expected
//            modelPurchaseOrder.productReceived.append(modelpurchaseOrderProductRecive)
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
