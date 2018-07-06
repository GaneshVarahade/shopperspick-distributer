//
//  CreateTransferViewController.swift
//  blaze
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift

public enum SelectedOption {
    case none
    case fromStore
    case fromInventory
    case toStore
    case toInventory
}
class CreateTransferViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    
    @IBOutlet weak var labelFromStore: UILabel!
    @IBOutlet weak var labelFromInventory: UILabel!
    
    @IBOutlet weak var labelToStore: UILabel!
    @IBOutlet weak var labelToInventory: UILabel!
    
    var dummyTextField: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    
    var modelLogin: LoginModel?
    var listFromInventory: List<ModelInventory>!
    var listToInventory: List<ModelInventory>!
    var listFromShop: List<ShopsModel>!
    var listToShop: List<ShopsModel>!
    
    var modelFromLocation: ModelLocation!
    var modelToLocation: ModelLocation!
    
    var selectedOption: SelectedOption = SelectedOption.none
    let colorSelectedData = UIColor.darkText
    let colorNonSelectedData = UIColor.lightGray
    
    var modelCreateTransfer: ModelCreateTransfer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Inventory"
        
        //add target to text field
        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))

        
        
        //addTarget(self, action: #selector(textFieldDidChange(_ :)), for: UIControlEvents.editingChanged)
        
        labelFromStore.isUserInteractionEnabled =  true
        labelFromStore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickFromStore)))
        
        labelFromInventory.isUserInteractionEnabled =  true
        labelFromInventory.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickFromInventory)))
        
        labelToStore.isUserInteractionEnabled =  true
        labelToStore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickToStore)))
        
        labelToInventory.isUserInteractionEnabled =  true
        labelToInventory.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onclickToInventory)))
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        dummyTextField = UITextField(frame: CGRect.zero)
        dummyTextField.inputView = pickerView
        dummyTextField.delegate = self
        view.addSubview(dummyTextField)
        
        dummyTextField?.keyboardToolbar.doneBarButton.setTarget(self, action:#selector(doneButtonTapped))
    }
    
    @objc func doneButtonTapped() {
        
        if selectedOption == SelectedOption.fromInventory {
            
            modelFromLocation.inventory = listFromInventory[pickerView.selectedRow(inComponent: 0)]
            loadData()
            
            
        }else if selectedOption == SelectedOption.toInventory {
            
            modelToLocation.inventory = listToInventory[pickerView.selectedRow(inComponent: 0)]
            loadData()
            
        }else if selectedOption == SelectedOption.fromStore {
            
            let shop = listFromShop[pickerView.selectedRow(inComponent: 0)]
            
            
            //selectedFromShop = shop
            modelFromLocation.shop = shop
            let modelInventories: ModelInventories? = RealmManager().read(type: ModelInventories.self, primaryKey: shop.id!)
            
            if let modelInventories = modelInventories {
                listFromInventory =  modelInventories.inventory
            }else{
                listFromInventory = List<ModelInventory>()
            }
            // When from store change, reset all values
            modelFromLocation.inventory = nil
            modelToLocation.shop = nil
            modelToLocation.inventory = nil
            
            loadData()
            
        }else if selectedOption == SelectedOption.toStore {
            let shop = listToShop[pickerView.selectedRow(inComponent: 0)]
            
            
            modelToLocation.shop = shop
            let modelInventories: ModelInventories? = RealmManager().read(type: ModelInventories.self, primaryKey: shop.id!)
            
            if let modelInventories = modelInventories {
                listToInventory =  modelInventories.inventory
            }else{
                listToInventory = List<ModelInventory>()
            }
            
            //Reset Inventory
            modelToLocation.inventory = nil
            
            loadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        modelCreateTransfer = ModelCreateTransfer()
        modelFromLocation = ModelLocation()
        modelToLocation = ModelLocation()
        modelLogin = RealmManager().readList(type: LoginModel.self).first
        loadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 
    @objc private func onclickFromStore() {
        selectedOption = SelectedOption.fromStore
        
        listToShop = nil
        listFromInventory = nil
        listToInventory = nil
        
        listFromShop = modelLogin?.shops
        dummyTextField.becomeFirstResponder()
        
    }
 
    @objc private func onclickFromInventory() {
        
        if modelFromLocation.shop == nil {
            showToast("Please select shop first")
            return
        }
        selectedOption = SelectedOption.fromInventory
        dummyTextField.becomeFirstResponder()
        
    }
    
    @objc private func onclickToStore() {
        
        if modelFromLocation.shop == nil || modelFromLocation.inventory == nil{
            showToast("Please select From Location First")
            return
        }
        selectedOption = SelectedOption.toStore
        listToShop = modelLogin?.shops
        dummyTextField.becomeFirstResponder()
    }
    
    @objc private func onclickToInventory() {
        if modelToLocation.shop == nil {
            showToast("Please select shop first")
            return
        }
        
        selectedOption = SelectedOption.toInventory
        dummyTextField.becomeFirstResponder()
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
      
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        /*
        
        if selectedOption == SelectedOption.fromInventory {
            
            modelFromLocation.inventory = listFromInventory[pickerView.selectedRow(inComponent: 0)]
            loadData()

            
        }else if selectedOption == SelectedOption.toInventory {
            
            modelToLocation.inventory = listToInventory[pickerView.selectedRow(inComponent: 0)]
            loadData()
            
        }else if selectedOption == SelectedOption.fromStore {
            
            let shop = listFromShop[pickerView.selectedRow(inComponent: 0)]
            
            
                //selectedFromShop = shop
                modelFromLocation.shop = shop
                print("\(listFromShop[pickerView.selectedRow(inComponent: 0)].name ?? "No Data")")
                let modelInventories: ModelInventories? = RealmManager().read(type: ModelInventories.self, primaryKey: shop.id!)
            
                if let modelInventories = modelInventories {
                    listFromInventory =  modelInventories.inventory
                }else{
                    listFromInventory = List<ModelInventory>()
                }
            // When from store change, reset all values
            modelFromLocation.inventory = nil
            modelToLocation.shop = nil
            modelToLocation.inventory = nil
            
            loadData()
 
        }else if selectedOption == SelectedOption.toStore {
            let shop = listToShop[pickerView.selectedRow(inComponent: 0)]
            
            
                modelToLocation.shop = shop
                print("\(listToShop[pickerView.selectedRow(inComponent: 0)].name ?? "No Data")")
                let modelInventories: ModelInventories? = RealmManager().read(type: ModelInventories.self, primaryKey: shop.id!)
            
                if let modelInventories = modelInventories {
                    listToInventory =  modelInventories.inventory
                }else{
                    listToInventory = List<ModelInventory>()
                }
            
            //Reset Inventory
            modelToLocation.inventory = nil
            
            loadData()
        }
         
         */
        
    }
    
    private func loadData(){
        
        if let selectedFromShop = modelFromLocation.shop {
            labelFromStore.text = selectedFromShop.name ?? "No name"
            labelFromStore.textColor = colorSelectedData
        }else{
            labelFromStore.text = "select"
            labelFromStore.textColor = colorNonSelectedData
            
        }
        
        if let selectedFromInventory = modelFromLocation.inventory {
            labelFromInventory.text = selectedFromInventory.name ?? "No name"
            labelFromInventory.textColor = colorSelectedData
        }else{
            labelFromInventory.text = "select"
            labelFromInventory.textColor = colorNonSelectedData
        }
        
        if let selectedToShop = modelToLocation.shop {
            labelToStore.text = selectedToShop.name ?? "No name"
            labelToStore.textColor = colorSelectedData
        }else{
            labelToStore.text = "select"
            labelToStore.textColor = colorNonSelectedData
        }
        
        if let selectedToInventory = modelToLocation.inventory {
            labelToInventory.text = selectedToInventory.name ?? "No name"
            labelToInventory.textColor = colorSelectedData
        }else{
            labelToInventory.text = "select"
            labelToInventory.textColor = colorNonSelectedData
        }
    }
    
    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if modelFromLocation.shop == nil || modelToLocation.shop == nil || modelFromLocation.inventory == nil || modelToLocation.inventory == nil{
            showToast("Please all options to proceed")
            return false
        }else{
            self.modelCreateTransfer.fromLocation = modelFromLocation
            self.modelCreateTransfer.toLocation = modelToLocation
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ScanLookUpViewController
        destinationVC?.modelCreateTransfer = self.modelCreateTransfer
}
}
extension CreateTransferViewController: UIPickerViewDataSource, UIPickerViewDelegate {
 
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if selectedOption == SelectedOption.fromInventory {
            
            return listFromInventory.count
            
        }else if selectedOption == SelectedOption.toInventory {
            
            return listToInventory.count
            
        }else if selectedOption == SelectedOption.fromStore {
            
            return listFromShop.count
            
        }else if selectedOption == SelectedOption.toStore {
            
            return listToShop.count
            
        }
        
        return 0
 
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if selectedOption == SelectedOption.fromInventory {
                 return listFromInventory[row].name ?? "No Inventory Name"
        }else if selectedOption == SelectedOption.fromStore {
            return listFromShop[row].name ?? "No shop name"
        }else if selectedOption == SelectedOption.toStore {
            return listToShop[row].name ?? "No shop name"
        }else if selectedOption == SelectedOption.toInventory {
            return listToInventory[row].name ?? "No Inventory Name"
        }
        
        return ""
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("\(modelLogin?.shops[row].name ?? "No Shop Name")")
    }
    
}
