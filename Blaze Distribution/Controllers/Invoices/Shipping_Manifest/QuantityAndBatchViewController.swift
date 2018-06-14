//
//  QuantityAndBatchViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class QuantityAndBatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var tempDataDict = [[String:Any]]()
    var batchIDList = [String]()
    var toolBar = UIToolbar()
    var doneButton = UIBarButtonItem()
    
    var batchPickerView : UIPickerView!
    
   // var invoiceItemsDelegate:InvoiceItemsDelegate?
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Quantity & Batch"
        
        batchIDList = ["ASHKDFNK","FDSSDFZ","SDFGFDSG","VCXVRDF","XVBCGFR"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:- Selector Methods
    
    @objc func donePicker(sender: UIButton) {
        print(sender.tag)
        batchPickerView.selectedRow(inComponent: 0)
        let index = IndexPath(row: sender.tag, section: 0)
        let cell: QuantityBatchTableViewCell = self.itemsTableView.cellForRow(at: index) as! QuantityBatchTableViewCell
        cell.batchTextField.text =  batchIDList[batchPickerView.selectedRow(inComponent: 0)]
        cell.batchTextField.resignFirstResponder()
    }
    
    // MARK:- UITableview Delegate/DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuantityBatchTableViewCell
        cell.productLabel.text = " \((tempDataDict[indexPath.row])["product_name"] as? String ?? "No value")"
        cell.quantityLabel.text = (tempDataDict[indexPath.row])["quantity"] as? String
        cell.batchTextField.text = (tempDataDict[indexPath.row])["batch_no"] as? String
        cell.batchTextField.tag = indexPath.row
        
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return batchIDList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return batchIDList[row]
    }
    
    // MARK:- Cell Delegate
    
    func didPressBatchBtn(_ tag: Int) {
        print("pressed \(tag)")
    }
    
    // MARK:- UIButton Events
    
    @IBAction func continueBtnPressed(_ sender: Any) {

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "INVOICE_ITEMS"), object: nil, userInfo: ["items":tempDataDict])
        
        for viewController in (self.navigationController?.viewControllers)! {

            if viewController is ShippingManifestViewController {
                //invoiceItemsDelegate?.getDataForInvoiceItems(dataDict: tempDataDict)
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
    
    // MARK:- UITextfield Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
        batchPickerView = UIPickerView()
        batchPickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 215)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action:#selector(donePicker))
        doneButton.tag = textField.tag
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        batchPickerView.delegate = self
        batchPickerView.dataSource = self
        textField.tintColor = UIColor.clear
        textField.inputView = batchPickerView
        textField.inputAccessoryView = toolBar
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
