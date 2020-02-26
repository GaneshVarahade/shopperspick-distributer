//
//  AddPaymentTableViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import Foundation

protocol AddPaymentDelegate {
    func getDataFromAddPayment(dataDict:ModelInvoice)
}

class AddPaymentTableViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate {

    var invoiceObj: ModelInvoice?
    var paymentDelegate:AddPaymentDelegate?
    var isfromDetails : Bool = false
    var paymentModel: ModelPaymentInfo?
    
    @IBOutlet weak var lblDueBalance: UILabel!
    @IBOutlet weak var lblBalanceDue: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var paymentTypeView: UIView!
    @IBOutlet weak var paymentDateView: UIView!
    @IBOutlet weak var referenceNoTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var debitCheckMarkImage: UIImageView!
    @IBOutlet weak var debitLabel: UILabel!
    @IBOutlet weak var achTransferLabel: UILabel!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var debitCardTextField: UITextField!
    @IBOutlet weak var achDateTextField: UITextField!
    @IBOutlet weak var paymentDateTextField: UITextField!
    
    var paymentType = AddPaymentType.DEBIT
    var selectedPaymentType : String = "DEBIT"
    let paymentTypes = ["Debit Card", "ACH Transfer","Credit Card","Cash","Check"]
    let datePicker = UIDatePicker()
    let paymentTypePicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = NSLocalizedString("AddPayTitle", comment: "")

//        paymentTypeView.dropShadow()
//        paymentDateView.dropShadow()
//        referenceNoView.dropShadow()
//        amountView.dropShadow()
//        notesView.dropShadow()
        
        self.paymentTypePicker.delegate = self
        self.paymentTypePicker.dataSource = self
        
        debitCheckMarkImage.isHidden = true
        
        notesTextView.text = "Enter your notes here..."
        notesTextView.textColor = UIColor.lightGray
        
        paymentTypeTextField.inputView = paymentTypePicker
        achDateTextField.inputView = datePicker
        paymentDateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
       
        manageTextfield()
        setDefaultData()
    }
    
    func  manageTextfield() {
        paymentTypeTextField.isUserInteractionEnabled = isfromDetails ? false : true
        debitCardTextField.isUserInteractionEnabled = isfromDetails ? false : true
        achDateTextField.isUserInteractionEnabled = isfromDetails ? false : true
        paymentDateTextField.isUserInteractionEnabled = isfromDetails ? false : true
        referenceNoTextField.isUserInteractionEnabled = isfromDetails ? false : true
        amountTextField.isUserInteractionEnabled = isfromDetails ? false : true
        notesTextView.isUserInteractionEnabled = isfromDetails ? false : true
        btnSubmit.isUserInteractionEnabled = isfromDetails ? false : true
    }
    
    func setDefaultData() {
        self.btnSubmit.isHidden = false
        if self.isfromDetails && (paymentModel != nil) {
            self.btnSubmit.isHidden = true
            notesTextView.textColor = UIColor.black
            // check payment method if set or set by default
            if let payment = paymentModel?.paymentType {
                self.selectedPaymentType = payment
                if payment == AddPaymentType.CASH.rawValue{
                    self.paymentType = AddPaymentType.CASH
                }else if payment == AddPaymentType.DEBIT.rawValue{
                    self.paymentType = AddPaymentType.DEBIT
                }else if payment == AddPaymentType.CREDIT.rawValue{
                    self.paymentType = AddPaymentType.CREDIT
                }else if payment == AddPaymentType.ACH_TRANSFER.rawValue{
                    self.paymentType = AddPaymentType.ACH_TRANSFER
                }else if payment == AddPaymentType.CHEQUE.rawValue{
                    self.paymentType = AddPaymentType.CHEQUE
                }
                
            }

            if let cardNo = paymentModel?.debitCardNo {
                if (cardNo == 0){
                     debitCardTextField?.text = "Not Available"
                    otherpaymentmethods()
                }else{
                     debitCardTextField?.text = String(format: "%d",cardNo)
                }
               
            } else {
                debitCardTextField?.text = "Not Available"
                otherpaymentmethods()
            }
            achDateTextField.text = paymentModel?.achDate ?? "Not Available"
            paymentDateTextField.text = DateFormatterUtil.format(dateTime:Double(DateIntConvertUtil.convert(dateTime: (paymentModel?.paymentDate)!, type: DateIntConvertUtil.Seconds)) , format:"dd/MM/yyyy")
            referenceNoTextField.text = paymentModel?.referenceNumber
            amountTextField.text = String(format:"$%.2f",(paymentModel?.amount)!)
            notesTextView.text = paymentModel?.notes ?? "Not Available"
            if let due = invoiceObj?.balanceDue, due > 0{
            lblBalanceDue.text = "\(due)";
            }else{
                lblBalanceDue.isHidden = true
                lblDueBalance.isHidden = true
            }
            
            paymentTypeTextField.text = paymentModel?.paymentType == "CHEQUE" ? "Check" : paymentModel?.paymentType
            
        } else {
            //Set Due balance
            if(invoiceObj != nil){
                 lblBalanceDue.text = String(format: "$%.2f",(invoiceObj?.balanceDue)!)
            }
        }
        if paymentModel?.paymentType != AddPaymentType.DEBIT.rawValue &&
            paymentModel?.paymentType != AddPaymentType.CREDIT.rawValue {
        self.setAddPaymentType(addPaymentType: self.paymentType)
        }
    }
    
    func setAddPaymentType(addPaymentType:AddPaymentType) {
        
        switch addPaymentType {
        case .DEBIT:
            // show for debit card
            debitLabel.text = "Debit"
            self.showDebitPaymentType(show: true)
        case .ACH_TRANSFER:
            // Hide debit card
            self.showDebitPaymentType(show: false)
        case .CASH:
            self.otherpaymentmethods()
        case .CREDIT:
            debitLabel.text = "Credit"
            self.showDebitPaymentType(show: true)
        case .CHEQUE:
            self.otherpaymentmethods()
        }
    }
    
    private func otherpaymentmethods(){
        debitCardTextField.isHidden = true
        debitLabel.isHidden = true
        achTransferLabel.isHidden = true
        achDateTextField.isHidden = true
        debitCheckMarkImage.isHidden = true
    }
    
    private func showDebitPaymentType(show:Bool) {
        debitCardTextField.isHidden = !show
        debitLabel.isHidden = !show
        if (debitCardTextField.text?.count)! >= 12 && show {
            debitCheckMarkImage.isHidden = false
        } else {
            debitCheckMarkImage.isHidden = true
        }
        // hide ACH transfer
        achTransferLabel.isHidden = show
        achDateTextField.isHidden = show
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 12
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 1:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 2:
            if deviceIdiom == .pad {
                return selectedPaymentType.uppercased() != "CASH" || selectedPaymentType.uppercased() != "CHEQUE" ? 70 : 0
            }
            else {
                return selectedPaymentType.uppercased() != "CASH" || selectedPaymentType.uppercased() != "CHEQUE" ? 50 : 0
            }
        case 3:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 4:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 5:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 6:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 7:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 8:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 9:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 10:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 11:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
            
        default:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        }
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AddPaymentCell", for: indexPath)
//        if indexPath.row == 0 {
//            tableView.allowsSelection = true
//        } else {
//            tableView.allowsSelection = false
//        }
////        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
//        return cell
//    }
    
    // MARK: - Table view Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at index \(indexPath.row)")
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.isHidden = (selectedPaymentType.uppercased() == "CASH" || selectedPaymentType.uppercased() == "CHEQUE") && indexPath.row == 2
    }
    
    // MARK: - UITextView Delegate/DataSource
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your notes here..." {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.textColor = UIColor.lightGray
            textView.text = "Enter your notes here..."
        }
    }
    
    
    // MARK: - UITextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == achDateTextField {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            textField.text = formatter.string(from: datePicker.date)
        } else if textField == paymentTypeTextField {
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == achDateTextField || textField == paymentDateTextField {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            textField.text = formatter.string(from: datePicker.date)
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == debitCardTextField {
                let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
                let characterSet = CharacterSet(charactersIn: string)
               // return allowedCharacters.isSuperset(of: characterSet)
            
            
            let maxLength = 12
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if newString.length >= maxLength { debitCheckMarkImage.isHidden = false } else {
                debitCheckMarkImage.isHidden = true
            }
            return newString.length <= maxLength && allowedCharacters.isSuperset(of: characterSet)
        }
        else if textField == amountTextField {
            let cs = NSCharacterSet(charactersIn: "0123456789.").inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
        }
        return true
    }
    
    
    
    // MARK:- Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - UIButton Events
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        // check data for selected payment type
        var debitCardNo = ""
        var achDate = ""
        if self.paymentType == .DEBIT || self.paymentType == .CREDIT {
            guard let cardNo = debitCardTextField.text, cardNo != "" else {
                self.showToast(NSLocalizedString("AddPay_Validation1", comment: ""))
                return
            }
            debitCardNo = cardNo
        } else if self.paymentType == .ACH_TRANSFER{
            guard let date = achDateTextField.text, date != "" else {
                self.showToast(NSLocalizedString("AddPay_Validation2", comment: ""))
                return
            }
            achDate = date
        }
        
        
        // If both card no. and ACH transfer date are required
//        guard let debitCardNo = debitCardTextField.text, debitCardNo != "" else {
//            self.showToast(NSLocalizedString("AddPay_Validation1", comment: ""))
//            return
//        }
//
//        guard let achDate = achDateTextField.text, achDate != "" else {
//            self.showToast(NSLocalizedString("AddPay_Validation2", comment: ""))
//            return
//        }
        
        guard let paymentDate = paymentDateTextField.text, paymentDate != "" else {
            self.showToast(NSLocalizedString("AddPay_Validation3", comment: ""))
            return
        }
        
        guard let referenceNo = referenceNoTextField.text, referenceNo != "" else {
            self.showToast(NSLocalizedString("AddPay_Validation4", comment: ""))
            return
        }
        
        guard let amount = amountTextField.text, amount != "" else {
            self.showToast(NSLocalizedString("AddPay_Validation5", comment: ""))
            return
        }
        
        guard let notes = notesTextView.text, notes != "Enter your notes here...", notes != "" else {
            self.showToast(NSLocalizedString("AddPay_Validation6", comment: ""))
            return
        }
        
        let enteredAmont:Int = Int((amountTextField.text! as NSString).intValue)
        if(enteredAmont > Int((invoiceObj?.balanceDue)!)){
        self.showToast(NSLocalizedString("AddPay_Validation7", comment: ""))
        return
        }
        
        let remainingamount = Int((invoiceObj?.balanceDue)!) - enteredAmont
        invoiceObj?.balanceDue = Double(remainingamount)
        
        let modelPaymanetInfo:ModelPaymentInfo = ModelPaymentInfo()
        modelPaymanetInfo.id = HexGenerator.sharedInstance().generate()
        modelPaymanetInfo.addPaymentType = self.paymentType
        modelPaymanetInfo.paymentType = self.selectedPaymentType
        modelPaymanetInfo.debitCardNo = Int(debitCardNo) ?? 000000
        modelPaymanetInfo.achDate = achDate
        modelPaymanetInfo.paymentDate = DateFormatterUtil.formatStringToInt(dateTime: paymentDateTextField.text!, format: "dd/MM/yyyy")
        modelPaymanetInfo.referenceNumber = referenceNo
        modelPaymanetInfo.amount = Double(amount)!
        modelPaymanetInfo.notes = notes
        modelPaymanetInfo.updated = true
        
        invoiceObj?.paymentInfo.append(modelPaymanetInfo)
        invoiceObj?.updated = true
        RealmManager().write(table: invoiceObj!)
        //SyncService.sharedInstance().syncData()
        
      // print(RealmManager().read(type: ModelInvoice.self, primaryKey:invoiceObj!.id!))
       //print(RealmManager().readList(type: ModelInvoice.self))
        
        //print("----PaymentInfo Data Save----")
        paymentDelegate?.getDataFromAddPayment(dataDict: invoiceObj!)
        self.navigationController?.popViewController(animated: true)
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

// MARK:- UIPickerView Delegate
extension AddPaymentTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paymentTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return paymentTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentTypeTextField.text = paymentTypes[row]
        switch row {
        case 0:
            self.paymentType = .DEBIT
            self.selectedPaymentType = AddPaymentType.DEBIT.rawValue
            self.setAddPaymentType(addPaymentType: self.paymentType)
        case 1:
            self.paymentType = .ACH_TRANSFER
            self.selectedPaymentType = AddPaymentType.ACH_TRANSFER.rawValue
            self.setAddPaymentType(addPaymentType: self.paymentType)
        case 2:
            self.paymentType = .CREDIT
            self.selectedPaymentType = AddPaymentType.CREDIT.rawValue
            self.setAddPaymentType(addPaymentType: self.paymentType)
        case 3:
            self.paymentType = .CASH
            self.selectedPaymentType = AddPaymentType.CASH.rawValue
            self.setAddPaymentType(addPaymentType: self.paymentType)
        case 4:
            self.paymentType = .CHEQUE
            self.selectedPaymentType = AddPaymentType.CHEQUE.rawValue
            self.setAddPaymentType(addPaymentType: self.paymentType)
        default:
            break
        }
        
        self.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .none)
//        self.view.endEditing(true)
    }
    
}
