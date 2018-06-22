                                //
//  ManifestInfoTableViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class ManifestInfoTableViewController: UITableViewController, signatureDelegate {

    var isAddManifest = Bool()
    var modelShippingMen: ModelShipingMenifest?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        if !isAddManifest {
            disableAllFields()
            signatureBtn.isHidden = true
        }

        setUI(manifestInfo: modelShippingMen)
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
    // MARK: - UI Update
    func setUI(manifestInfo: ModelShipingMenifest?) {
        
        guard let manifestInfo = manifestInfo else {
            return
        }
        
        manifestNoTextField.text = manifestInfo.shippingManifestNo
        companyNameTextField.text = manifestInfo.receiverCompany
        typeTextField.text = manifestInfo.receiverType
        contactTextField.text = manifestInfo.receiverContact ?? "-/-"
        licenceNoTextField.text = manifestInfo.receiverLicense ?? "-/-"
        addressTextField.text = "\(manifestInfo.receiverAddress?.city ?? "-"), \(manifestInfo.receiverAddress?.country ?? "-")"

        if !isAddManifest {
            deliveryDateTextField.text = "\(manifestInfo.deliveryDate)"
            deliveryTimeTextField.text = "-/-"
            driverNameTextField.text = manifestInfo.driverName
            driverLicenceTextField.text = manifestInfo.driverLicenseNumber ?? "-/-"
            driverMakeTextField.text = manifestInfo.vehicleMake ?? "-/-"
            driverModelTextField.text = manifestInfo.vehicleModel ?? "-/-"
            driverColorTextField.text = "-/-"
            driverLicencePlateTextField.text = manifestInfo.driverLicenPlate ?? "-/-"
        }
        
    }
    
    private func disableAllFields(){
        
        signatureBtn.isEnabled = false
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 19
    }

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
        self.signatureBtn.setImage(signImg, for: .normal)
    }

    func getShippingMenifest() -> ModelShipingMenifest {
        return modelShippingMen!
    }
}
