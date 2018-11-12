                                //
//  ManifestInfoTableViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
                               
protocol validateFieldsProtocol {
    func validateFields()
}
                                
class ManifestInfoTableViewController: UITableViewController, signatureDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Property
    var isAddManifest = Bool()
    var modelShippingMen: ModelShipingMenifest?
    var inProgressShippingMen: ModelShipingMenifest?
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    var driverInfo :[ModelDriverInfo] = []
    var selectedDriverInfo:ModelDriverInfo?
    var invoiceDetailsDict: ModelInvoice?
    var pickerView: UIPickerView = UIPickerView()
    
    // MARK: - Outlets
    @IBOutlet weak var signatureImgView: UIImageView!
    @IBOutlet weak var signatureBtn: UIButton!
    @IBOutlet weak var manifestNoTextField: UITextField!
    @IBOutlet weak var deliveryDateTextField: UITextField!
    @IBOutlet weak var deliveryTimeTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var licenceNoTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var driverNameTextField: UITextField!
    @IBOutlet weak var driverLicenceTextField: UITextField!
    @IBOutlet weak var driverMakeTextField: UITextField!
    @IBOutlet weak var driverModelTextField: UITextField!
    @IBOutlet weak var driverColorTextField: UITextField!
    @IBOutlet weak var driverLicencePlateTextField: UITextField!
    
    @IBOutlet weak var addSignatureBtn: UIButton!
    
    var validateFieldsDelegate: validateFieldsProtocol?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        self.disableDriversTextField()
        // get if the current manifest progress is saved
        self.getManifestInProgress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //Read Driver info list from database
        self.driverInfo = RealmManager().readList(type: ModelDriverInfo.self)
        //print(self.modelShippingMen)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        //driverNameTextField = UITextField(frame: CGRect.zero)
        driverNameTextField.inputView = pickerView
        driverNameTextField.delegate = self
        driverNameTextField?.keyboardToolbar.doneBarButton.setTarget(self, action:#selector(doneButtonTapped))
    }
    
    @objc func doneButtonTapped() {
        //save selected driver info
        self.selectedDriverInfo = self.driverInfo[self.pickerView.selectedRow(inComponent: 0)]
        if let licenNumber = self.selectedDriverInfo {
            //set value to text field
            let fullName = "\(licenNumber.driverName ?? "Not") \(licenNumber.driverLastName ?? "Available")"
        
            driverNameTextField.text = fullName
            //driverNameTextField.text = licenNumber.driverName ?? "Not Available"
            driverLicenceTextField.text = licenNumber.driverLicenseNumber ?? "Not Available"
            driverMakeTextField.text = licenNumber.vehicleMake ?? "Not Available"
            driverModelTextField.text = licenNumber.vehicleModel ?? "Not Available"
            driverColorTextField.text = licenNumber.vehicleColor ?? "Not Available"
            driverLicencePlateTextField.text = licenNumber.vehicleLicensePlate ?? "Not Available"
        
            modelShippingMen?.driverName = licenNumber.driverName
            modelShippingMen?.driverLicenseNumber = licenNumber.driverLicenseNumber
            modelShippingMen?.vehicleMake = licenNumber.vehicleMake
            modelShippingMen?.vehicleModel = licenNumber.vehicleModel
            modelShippingMen?.vehicleColor = licenNumber.vehicleColor
            modelShippingMen?.driverLicenPlate = licenNumber.vehicleLicensePlate
            modelShippingMen?.driverId = licenNumber.driverId
        } else {
            return
        }
    
    }

    override func viewDidAppear(_ animated: Bool) {
        if !isAddManifest {
            disableAllFields()
            //signatureBtn.isHidden = true
            addSignatureBtn.isHidden = true
        }

        setUI(manifestInfo: modelShippingMen)
        setDataWithCurrentManifest(manifestInfo: inProgressShippingMen)
        
        let colorView = UIView()
        colorView.backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectedBackgroundView = colorView
    }
    
    @IBAction func btnDriverNameClicked(_ sender: Any) {
//        driverNameTextField.inputView = pickerView
//        driverNameTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
//        if isAddManifest {
//            //modelShippingMen?.deliveryDate = Int(Date().timeIntervalSince1970)
//            modelShippingMen?.receiverCompany = companyNameTextField.text
//            modelShippingMen?.receiverType = typeTextField.text
//            modelShippingMen?.receiverContact = contactTextField.text
//            modelShippingMen?.receiverLicense = licenceNoTextField.text
//            let addressObj = ModelAddres()
//            addressObj.address = addressTextField.text
//            modelShippingMen?.receiverAddress = addressObj
//            modelShippingMen?.driverName = driverNameTextField.text
//            modelShippingMen?.driverLicenseNumber = driverLicenceTextField.text
//            modelShippingMen?.vehicleMake = driverMakeTextField.text
//            modelShippingMen?.vehicleModel = driverModelTextField.text
//            modelShippingMen?.vehicleColor = driverColorTextField.text
//            modelShippingMen?.driverLicenPlate = driverLicencePlateTextField.text
//        }
    }
//    private func seuptReceiver(_ invoice: ModelInvoice?){
//
//        guard  let modelInvoice = invoice else {
//            return
//        }
//
//        companyNameTextField.text = modelInvoice.vendorCompany ?? "-/-"
//        typeTextField.text = modelInvoice.vendorCompanyType ?? "-/-"
//        contactTextField.text = modelInvoice.vendorPhone ?? "-/-"
//        licenceNoTextField.text = modelInvoice.vendorLicenseNumber ?? "-/-"
//        addressTextField.text = "\(modelInvoice.vendorCity ?? "-"), \(modelInvoice.vendorCountry ?? "-")"
//
//    }
    
    func getManifestInProgress() {
        // retrieving a value for a key
//        if let data = UserDefaults.standard.data(forKey: "\(invoiceDetailsDict?.invoiceNumber ?? "default")"),
//            let manifestData = NSKeyedUnarchiver.unarchiveObject(with: data) as? ModelShipingMenifest {
//            inProgressShippingMen = manifestData
//        } else {
//            inProgressShippingMen = modelShippingMen
//        }
        
        let inProgressManifests = RealmManager().readList(type: ModelShipingMenifest.self)
//        let inProgressManifest = RealmManager().read(type: ModelShipingMenifest.self, primaryKey: (invoiceDetailsDict?.invoiceNumber)!)
        print("in progress manifest >>>>>>>> \(String(describing: inProgressManifests))")
    }
    
    func setManifestInProgress() {
        guard let data = inProgressShippingMen else {
            return
        }
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
//        UserDefaults.standard.set(encodedData, forKey: "\(invoiceDetailsDict?.invoiceNumber ?? "default")")
        
        RealmManager().write(table: data)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        print("backkkkkk")
        // save data for in progress
        inProgressShippingMen = modelShippingMen    // for signature and id
        inProgressShippingMen?.shippingManifestNo = manifestNoTextField.text
        inProgressShippingMen?.deliveryDate = DateIntConvertUtil.convert(dateTime: Int(datePicker.date.timeIntervalSince1970), type: DateIntConvertUtil.Miliseconds)
        inProgressShippingMen?.deliveryTime = DateIntConvertUtil.convert(dateTime:Int(timePicker.date.timeIntervalSince1970) , type: DateIntConvertUtil.Miliseconds)
        inProgressShippingMen?.receiverCompany = companyNameTextField.text
        inProgressShippingMen?.receiverType = typeTextField.text
        inProgressShippingMen?.receiverContact = contactTextField.text
        inProgressShippingMen?.receiverLicense = licenceNoTextField.text
        inProgressShippingMen?.receiverAddress?.address = addressTextField.text
        if let licenNumber = self.selectedDriverInfo {
            inProgressShippingMen?.driverName = licenNumber.driverName
            inProgressShippingMen?.driverLicenseNumber = licenNumber.driverLicenseNumber
            inProgressShippingMen?.vehicleMake = licenNumber.vehicleMake
            inProgressShippingMen?.vehicleModel = licenNumber.vehicleModel
            inProgressShippingMen?.vehicleColor = licenNumber.vehicleColor
            inProgressShippingMen?.driverLicenPlate = licenNumber.vehicleLicensePlate
            inProgressShippingMen?.driverId = licenNumber.driverId
        }
        // save to user default
        self.setManifestInProgress()
        // pop after saving data for in progress
        self.navigationController?.popViewController(animated: true)
        
        
        
        
        // Perform your custom actions
//        if modelShippingMen == inProgressShippingMen {
//            self.navigationController?.popViewController(animated: true)
//        } else {
//            let alertController = UIAlertController(title: "Alert", message: "Do you want to save your current progress?", preferredStyle: .alert)
//            let yesAction = UIAlertAction(title: "YES", style: .cancel) { (action:UIAlertAction) in
//                self.setManifestInProgress()
//                self.navigationController?.popViewController(animated: true)
//            }
//            let noAction = UIAlertAction(title: "No, Thanks", style: .destructive) { (action:UIAlertAction) in
//                self.navigationController?.popViewController(animated: true)
//            }
//            alertController.addAction(yesAction)
//            alertController.addAction(noAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
    }

    // MARK: - UI Update
    func setUI(manifestInfo: ModelShipingMenifest?) {
        
        deliveryDateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        
        deliveryTimeTextField.inputView = timePicker
        timePicker.datePickerMode = .time
        
        guard let manifestInfo = manifestInfo else {
            return
        }
        
        if let signImg = StoreImage.getSavedImage(name: manifestInfo.shippingManifestNo!) {
            //signatureBtn.setImage(signImg, for: .normal)
            signatureImgView.image = signImg
            signatureImgView.layer.borderWidth = 0
        }
        
        manifestNoTextField.text = manifestInfo.shippingManifestNo
        companyNameTextField.text = manifestInfo.receiverCompany
        typeTextField.text = manifestInfo.receiverType
        contactTextField.text = manifestInfo.receiverContact ?? "-/-"
        licenceNoTextField.text = manifestInfo.receiverLicense ?? "-/-"
        addressTextField.text = "\(manifestInfo.receiverAddress?.address ?? "-"), \(manifestInfo.receiverAddress?.city ?? "-"), \(manifestInfo.receiverAddress?.country ?? "-")"

        if !isAddManifest {
            deliveryDateTextField.text = DateFormatterUtil.format(dateTime: Double(DateIntConvertUtil.convert(dateTime:manifestInfo.deliveryDate , type: DateIntConvertUtil.Seconds)), format: DateFormatterUtil.mmddyyyy)
            
            deliveryTimeTextField.text = DateFormatterUtil.format(dateTime: Double(DateIntConvertUtil.convert(dateTime:manifestInfo.deliveryTime , type: DateIntConvertUtil.Seconds)), format: DateFormatterUtil.hhmma)
            
            driverNameTextField.text = manifestInfo.driverName
            driverLicenceTextField.text = manifestInfo.driverLicenseNumber ?? "Not available"
            driverMakeTextField.text = manifestInfo.vehicleMake ?? "Not available"
            driverModelTextField.text = manifestInfo.vehicleModel ?? "Not available"
            driverColorTextField.text = manifestInfo.vehicleColor ?? "Not available"
            driverLicencePlateTextField.text = manifestInfo.driverLicenPlate ?? "Not available"
            
            // Assine Image from asset
            if let imageAsset : ModelSignatureAsset = manifestInfo.signatureAsset{
                if let url = imageAsset.getNSURL(){
                    self.signatureImgView.imageFromSecureURL(url, placeHolder: "loadingImage")
                }
            }
        }
        
    }
    
    func setDataWithCurrentManifest(manifestInfo: ModelShipingMenifest?) {
        guard let manifestInfo = manifestInfo else {
            return
        }
        if let signImg = StoreImage.getSavedImage(name: manifestInfo.shippingManifestNo!) {
            //signatureBtn.setImage(signImg, for: .normal)
            signatureImgView.image = signImg
            signatureImgView.layer.borderWidth = 0
        }
        manifestNoTextField.text = manifestInfo.shippingManifestNo
        companyNameTextField.text = manifestInfo.receiverCompany
        typeTextField.text = manifestInfo.receiverType
        contactTextField.text = manifestInfo.receiverContact ?? "-/-"
        licenceNoTextField.text = manifestInfo.receiverLicense ?? "-/-"
        addressTextField.text = "\(manifestInfo.receiverAddress?.address ?? "-"), \(manifestInfo.receiverAddress?.city ?? "-"), \(manifestInfo.receiverAddress?.country ?? "-")"
        
        deliveryDateTextField.text = DateFormatterUtil.format(dateTime: Double(DateIntConvertUtil.convert(dateTime:manifestInfo.deliveryDate , type: DateIntConvertUtil.Seconds)), format: DateFormatterUtil.mmddyyyy)
        
        deliveryTimeTextField.text = DateFormatterUtil.format(dateTime: Double(DateIntConvertUtil.convert(dateTime:manifestInfo.deliveryTime , type: DateIntConvertUtil.Seconds)), format: DateFormatterUtil.hhmma)
        
        driverNameTextField.text = manifestInfo.driverName
        driverLicenceTextField.text = manifestInfo.driverLicenseNumber ?? ""
        driverMakeTextField.text = manifestInfo.vehicleMake ?? ""
        driverModelTextField.text = manifestInfo.vehicleModel ?? ""
        driverColorTextField.text = manifestInfo.vehicleColor ?? ""
        driverLicencePlateTextField.text = manifestInfo.driverLicenPlate ?? ""
        
        // Assine Image from asset
        if let imageAsset : ModelSignatureAsset = manifestInfo.signatureAsset{
            if let url = imageAsset.getNSURL(){
                self.signatureImgView.imageFromSecureURL(url, placeHolder: "loadingImage")
            }
        }
        
    }
    
    private func disableDriversTextField(){
        driverLicenceTextField.isUserInteractionEnabled = false
        driverMakeTextField.isUserInteractionEnabled = false
        driverModelTextField.isUserInteractionEnabled = false
        driverColorTextField.isUserInteractionEnabled = false
        driverLicencePlateTextField.isUserInteractionEnabled = false
    }
    
    private func disableAllFields(){
        //signatureBtn.isEnabled = false
        manifestNoTextField.isUserInteractionEnabled = false
        deliveryDateTextField.isUserInteractionEnabled = false
        deliveryTimeTextField.isUserInteractionEnabled = false
        companyNameTextField.isUserInteractionEnabled = false
        typeTextField.isUserInteractionEnabled = false
        contactTextField.isUserInteractionEnabled = false
        licenceNoTextField.isUserInteractionEnabled = false
        addressTextField.isUserInteractionEnabled = false
        driverNameTextField.isUserInteractionEnabled = false
        driverLicenceTextField.isUserInteractionEnabled = false
        driverMakeTextField.isUserInteractionEnabled = false
        driverModelTextField.isUserInteractionEnabled = false
        driverColorTextField.isUserInteractionEnabled = false
        driverLicencePlateTextField.isUserInteractionEnabled = false
    }
    
    
    func validateFields() {
        //print("validate")
        let signImg = StoreImage.getSavedImage(name: (modelShippingMen?.shippingManifestNo!)!)
        
        if modelShippingMen?.deliveryDate == 0 {
            deliveryDateTextField.layer.borderWidth = 1
            deliveryDateTextField.layer.borderColor = UIColor.red.cgColor
            deliveryDateTextField.becomeFirstResponder()
            return
        }
        else if modelShippingMen?.deliveryTime == 0 {
            deliveryTimeTextField.layer.borderWidth = 1
            deliveryTimeTextField.layer.borderColor = UIColor.red.cgColor
            deliveryTimeTextField.becomeFirstResponder()
            return
        }
        
        guard let company = modelShippingMen?.receiverCompany, company != "" else {
            companyNameTextField.layer.borderWidth = 1
            companyNameTextField.layer.borderColor = UIColor.red.cgColor
            companyNameTextField.becomeFirstResponder()
            return
        }
        guard let type = modelShippingMen?.receiverType, type != "" else {
            typeTextField.layer.borderWidth = 1
            typeTextField.layer.borderColor = UIColor.red.cgColor
            typeTextField.becomeFirstResponder()
            return
        }
        guard let contact = modelShippingMen?.receiverContact, contact != "" else {
            contactTextField.layer.borderWidth = 1
            contactTextField.layer.borderColor = UIColor.red.cgColor
            contactTextField.becomeFirstResponder()
            return
        }
        guard let licence = modelShippingMen?.receiverLicense, licence != "" else {
            licenceNoTextField.layer.borderWidth = 1
            licenceNoTextField.layer.borderColor = UIColor.red.cgColor
            licenceNoTextField.becomeFirstResponder()
            return
        }
        guard let address = modelShippingMen?.receiverAddress?.address, address != "" else {
            addressTextField.layer.borderWidth = 1
            addressTextField.layer.borderColor = UIColor.red.cgColor
            addressTextField.becomeFirstResponder()
            return
        }
//        guard let driverName = modelShippingMen?.driverName, driverName != "" else {
//            driverNameTextField.layer.borderWidth = 1
//            driverNameTextField.layer.borderColor = UIColor.red.cgColor
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(row: 11, section: 0)
//                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                self.driverNameTextField.becomeFirstResponder()
//            }
//            return
//        }
//        guard let driverLicence = modelShippingMen?.driverLicenseNumber, driverLicence != "" else {
//            driverLicenceTextField.layer.borderWidth = 1
//            driverLicenceTextField.layer.borderColor = UIColor.red.cgColor
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(row: 12, section: 0)
//                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                self.driverLicenceTextField.becomeFirstResponder()
//            }
//            return
//        }
//        guard let vehicleMake = modelShippingMen?.vehicleMake, vehicleMake != "" else {
//            driverMakeTextField.layer.borderWidth = 1
//            driverMakeTextField.layer.borderColor = UIColor.red.cgColor
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(row: 13, section: 0)
//                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                self.driverMakeTextField.becomeFirstResponder()
//            }
//            return
//        }
//        guard let vehicleModel = modelShippingMen?.vehicleModel, vehicleModel != "" else {
//            driverModelTextField.layer.borderWidth = 1
//            driverModelTextField.layer.borderColor = UIColor.red.cgColor
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(row: 14, section: 0)
//                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                self.driverModelTextField.becomeFirstResponder()
//            }
//            return
//        }
//        guard let vehicleColor = modelShippingMen?.vehicleColor, vehicleColor != "" else {
//            driverColorTextField.layer.borderWidth = 1
//            driverColorTextField.layer.borderColor = UIColor.red.cgColor
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(row: 15, section: 0)
//                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                self.driverColorTextField.becomeFirstResponder()
//            }
//            return
//        }
//        guard let driverLicenPlate = modelShippingMen?.driverLicenPlate, driverLicenPlate != "" else {
//            driverLicencePlateTextField.layer.borderWidth = 1
//            driverLicencePlateTextField.layer.borderColor = UIColor.red.cgColor
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(row: 16, section: 0)
//                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//                self.driverLicencePlateTextField.becomeFirstResponder()
//            }
//            return
//        }
        guard signImg != nil else {
            signatureImgView.layer.borderWidth = 1
            signatureImgView.layer.borderColor = UIColor.red.cgColor
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 18, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
            return
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.borderStyle = .none
        if textField == deliveryDateTextField {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            modelShippingMen?.deliveryDate = DateIntConvertUtil.convert(dateTime: Int(datePicker.date.timeIntervalSince1970), type: DateIntConvertUtil.Miliseconds)
            textField.text = formatter.string(from: datePicker.date)
        }
        else if textField == deliveryTimeTextField {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            modelShippingMen?.deliveryTime = DateIntConvertUtil.convert(dateTime:Int(timePicker.date.timeIntervalSince1970) , type: DateIntConvertUtil.Miliseconds)
            textField.text = formatter.string(from: timePicker.date)
        }
        else if textField == companyNameTextField {
            if isAddManifest {
                modelShippingMen?.receiverCompany = companyNameTextField.text
            }
        }
        else if textField == typeTextField {
            if isAddManifest {
                modelShippingMen?.receiverType = typeTextField.text
            }
        }
        else if textField == contactTextField {
            if isAddManifest {
                modelShippingMen?.receiverContact = contactTextField.text
            }
        }
        else if textField == licenceNoTextField {
            if isAddManifest {
                modelShippingMen?.receiverLicense = licenceNoTextField.text
            }
        }
        else if textField == addressTextField {
            if isAddManifest {
                let addressObj = ModelAddres()
                addressObj.address = addressTextField.text
                modelShippingMen?.receiverAddress?.address = addressTextField.text
            }
        }
        else if textField == driverNameTextField {
            driverNameTextField.inputView = pickerView
            driverNameTextField.delegate = self

//            if isAddManifest {
//                modelShippingMen?.driverName = driverNameTextField.text
//            }
        }
//        else if textField == driverLicenceTextField {
//            if isAddManifest {
//                modelShippingMen?.driverLicenseNumber = driverLicenceTextField.text
//            }
//        }
//        else if textField == driverMakeTextField {
//            if isAddManifest {
//                modelShippingMen?.vehicleMake = driverMakeTextField.text
//            }
//        }
//        else if textField == driverModelTextField {
//            if isAddManifest {
//                modelShippingMen?.vehicleModel = driverModelTextField.text
//            }
//        }
//        else if textField == driverColorTextField {
//            if isAddManifest {
//                modelShippingMen?.vehicleColor = driverColorTextField.text
//            }
//        }
//        else if textField == driverLicencePlateTextField {
//            if isAddManifest {
//                modelShippingMen?.driverLicenPlate = driverLicencePlateTextField.text
//            }
//        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == driverNameTextField {
            return  false
        }else{
            return true
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 19
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 19 {
            self.performSegue(withIdentifier: "addSignatureSegue", sender: nil)
        }
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        cell.backgroundColor = UIColor.clear
//
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 60
            }
            case 1:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 3:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 4:
                if deviceIdiom == .pad {
                    return 70
                }
                else {
                    return 60
            }
            case 5:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 6:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 7:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 8:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 9:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 10:
                if deviceIdiom == .pad {
                    return 70
                }
                else {
                    return 60
            }
            case 11:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 12:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 13:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 14:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 16:
                if deviceIdiom == .pad {
                    return 60
                }
                else {
                    return 45
            }
            case 17:
                if deviceIdiom == .pad {
                    return 70
                }
                else {
                    return 60
            }
            case 18:
                if deviceIdiom == .pad {
                    return 200
                }
                else {
                    return 130
            }
        default:
            if deviceIdiom == .pad {
                return 60
            }
            else {
                return 45
            }
        }
    }
     
    // MARK:- Sign Delegate
    func getSignatureImg(signImg: UIImage) {
        //self.signatureBtn.setImage(signImg, for: .normal)
        //self.signatureBtn.setBackgroundImage(signImg, for: .normal)
        signatureImgView.image = signImg
    }

    func getShippingMenifest() -> ModelShipingMenifest {
        return modelShippingMen!
    }
    
    // MARK: - UINavigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addSignatureSegue" {
            let obj = segue.destination as! SignatureViewController
            obj.modelShippingMen = self.modelShippingMen
            obj.isAddManifest = self.isAddManifest
            obj.invoiceDetailsDict = self.invoiceDetailsDict
        }
    }
    
    // MARK - PickerView Delegate
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return driverInfo.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(driverInfo[row].driverName ?? "Not") \(driverInfo[row].driverLastName ?? "Available")"
        //return driverInfo[row].driverName ?? ""
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedDriverInfo = driverInfo[row]
        //print("\(modelLogin?.shops[row].name ?? "No Shop Name")")
    }
    
}
