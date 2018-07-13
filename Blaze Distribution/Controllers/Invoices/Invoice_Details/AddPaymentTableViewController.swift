//
//  AddPaymentTableViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

protocol AddPaymentDelegate {
    func getDataFromAddPayment(dataDict:ModelInvoice)
}

class AddPaymentTableViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate {

    var invoiceObj: ModelInvoice?
    var paymentDelegate:AddPaymentDelegate?
    var isfromDetails : Bool = false
    var paymentModel: ModelPaymentInfo?
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var paymentTypeView: UIView!
    @IBOutlet weak var paymentDateView: UIView!
    @IBOutlet weak var referenceNoTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var debitCheckMarkImage: UIImageView!
    
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var debitCardTextField: UITextField!
    @IBOutlet weak var achDateTextField: UITextField!
    @IBOutlet weak var paymentDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Add Payment"

//        paymentTypeView.dropShadow()
//        paymentDateView.dropShadow()
//        referenceNoView.dropShadow()
//        amountView.dropShadow()
//        notesView.dropShadow()
        
        debitCheckMarkImage.isHidden = true
        
        notesTextView.text = "Enter your notes here..."
        notesTextView.textColor = UIColor.lightGray
        
        achDateTextField.inputView = datePicker
        paymentDateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        manageTextfield()
        setDefaultData()
    }
    
    func  manageTextfield() {
        debitCardTextField.isUserInteractionEnabled = isfromDetails ? false : true
        achDateTextField.isUserInteractionEnabled = isfromDetails ? false : true
        paymentDateTextField.isUserInteractionEnabled = isfromDetails ? false : true
        referenceNoTextField.isUserInteractionEnabled = isfromDetails ? false : true
        amountTextField.isUserInteractionEnabled = isfromDetails ? false : true
        notesTextView.isUserInteractionEnabled = isfromDetails ? false : true
        btnSubmit.isUserInteractionEnabled = isfromDetails ? false : true
    }
    
    func setDefaultData() {
        if self.isfromDetails && (paymentModel != nil) {
            debitCardTextField?.text = String(format: "%d", (paymentModel?.debitCardNo)!)
            achDateTextField.text = paymentModel?.achDate
            paymentDateTextField.text = ""
            referenceNoTextField.text = paymentModel?.referenceNumber
            amountTextField.text = String(format:"%.1f",(paymentModel?.amount)!)
            notesTextView.text = paymentModel?.notes
        }
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
                return 70
            }
            else {
                return 50
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
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == achDateTextField || textField == paymentDateTextField{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            textField.text = formatter.string(from: datePicker.date)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == debitCardTextField {
            let maxLength = 12
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if newString.length >= maxLength { debitCheckMarkImage.isHidden = false } else {
                debitCheckMarkImage.isHidden = true
            }
            return newString.length <= maxLength
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
        
        guard let debitCardNo = debitCardTextField.text, debitCardNo != "" else {
            self.showToast("Please enter debit card no")
            return
        }
        
        guard let achDate = achDateTextField.text, achDate != "" else {
            self.showToast("Please select ACH date")
            return
        }
        
        guard let paymentDate = paymentDateTextField.text, paymentDate != "" else {
            self.showToast("Please select payment date")
            return
        }
        
        guard let referenceNo = referenceNoTextField.text, referenceNo != "" else {
            self.showToast("Please enter reference no")
            return
        }
        
        guard let amount = amountTextField.text, amount != "" else {
            self.showToast("Please enter amount")
            return
        }
        
        guard let notes = notesTextView.text, notes != "Enter your notes here...", notes != "" else {
            self.showToast("Please enter notes")
            return
        }
        
        let modelPaymanetInfo:ModelPaymentInfo = ModelPaymentInfo()
        modelPaymanetInfo.id = HexGenerator.sharedInstance().generate()
        modelPaymanetInfo.debitCardNo = Int(debitCardNo)!
        modelPaymanetInfo.achDate = achDate
        modelPaymanetInfo.paymentDate = 0
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
