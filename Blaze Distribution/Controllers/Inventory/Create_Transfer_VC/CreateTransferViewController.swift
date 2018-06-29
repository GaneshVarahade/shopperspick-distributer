//
//  CreateTransferViewController.swift
//  blaze
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class CreateTransferViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    
    @IBOutlet weak var labelFromStore: UILabel!
    @IBOutlet weak var labelFromInventory: UILabel!
    
    var dummyTextField: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Inventory"
        
        labelFromStore.isUserInteractionEnabled =  true
        labelFromStore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickFromInventory)))
        
        labelFromInventory.isUserInteractionEnabled =  true
        labelFromInventory.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickFromInventory)))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        dummyTextField = UITextField(frame: CGRect.zero)
        dummyTextField.inputView = pickerView
        view.addSubview(dummyTextField)
    }

    @objc private func onclickFromInventory() {
        dummyTextField.becomeFirstResponder()
    }

    @IBAction func continueBtnPressed(_ sender: Any) {
       // let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScanLookUpViewController")
       // self.navigationController?.pushViewController(obj, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Title is tile"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showToast("\(row)")
    }
}
