//
//  ShippingManifestViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift

protocol ShippingMenifestConfirmSelectedProductsDelegate {
    func confirmSelectedProducts(modelSelectedProducts: List<ModelRemainingProduct>)
}

protocol newConfirmFinalProtocol {
    func confirmShip(objShip : ModelShipingMenifest)
}

class ShippingManifestViewController: UIViewController, ShippingMenifestConfirmSelectedProductsDelegate,validationProtocol,validateFieldsProtocol {

//    var manifestInfoViewController: ManifestInfoTableViewController?
    var invoiceDetailsDict: ModelInvoice?
    var isAddManifest = Bool()
    var modelShippingMen: ModelShipingMenifest?
    var shippiingMenifestConfirm: ShippingMenifestConfirmDelegate?
    
    var manifestDetailController:ManifestInfoTableViewController?
    var itemsToShipController:CreateManifestItemSelectionVC?
    var newShipDelaget : newConfirmFinalProtocol!
    
    @IBOutlet weak var shippingSegmentControler: UISegmentedControl!
    @IBOutlet weak var itemsToShipContainerView: UIView!
    @IBOutlet weak var manifestInfoContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shippingSegmentControler.selectedSegmentIndex = 0
        manifestInfoContainerView.isHidden = false
        itemsToShipContainerView.isHidden = true
        
        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: manifestDetailController, action: #selector(manifestDetailController?.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        if shippingSegmentControler.selectedSegmentIndex == 0 {
            manifestInfoContainerView.isHidden = false
            itemsToShipContainerView.isHidden = true
        }
        else {
            if isAddManifest{
                if isshipperInfofill(){
                    manifestInfoContainerView.isHidden = true
                    itemsToShipContainerView.isHidden = false
                }else{
                    manifestInfoContainerView.isHidden = false
                    itemsToShipContainerView.isHidden = true
                    shippingSegmentControler.selectedSegmentIndex = 0
                    self.showAlert(title: "Message", message: "Please fill all information to proceed further", closure:{})
                }
            }else{
                manifestInfoContainerView.isHidden = true
                itemsToShipContainerView.isHidden = false
            }
        }
    }
    
    func changeUI() {
        shippingSegmentControler.selectedSegmentIndex = 0
        manifestInfoContainerView.isHidden = false
        itemsToShipContainerView.isHidden = true
    }
    
    func isshipperInfofill()->Bool{
        var canship = true
        let signImg = StoreImage.getSavedImage(name: (self.modelShippingMen?.shippingManifestNo!)!)
        
        if self.modelShippingMen?.deliveryDate == 0 {
            canship = false
        }
        if self.modelShippingMen?.deliveryTime == 0 {
            canship = false
        }
         if self.modelShippingMen?.receiverCompany == ""{
            canship = false
        }
        if self.modelShippingMen?.receiverType == ""{
            canship = false
        }
        if self.modelShippingMen?.receiverContact == ""{
            canship = false
        }
        if  self.modelShippingMen?.receiverLicense == ""{
            canship = false
        }
        if self.modelShippingMen?.receiverAddress?.address == "" {
            canship = false
        }
        if self.modelShippingMen?.driverName == ""{
            canship = false
        }
        if signImg == nil {
            canship = false
        }
        
        return canship
        }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "manifestDetailsSegue" {
            
            let modelAddress = ModelAddres()
            modelAddress.address = invoiceDetailsDict?.vendorAddress
            modelAddress.city = invoiceDetailsDict?.vendorCity
            modelAddress.country = invoiceDetailsDict?.vendorCountry
            modelAddress.state = invoiceDetailsDict?.vendorState
            modelAddress.zipCode = invoiceDetailsDict?.vendorZipcode
            
            modelShippingMen?.receiverCompany = invoiceDetailsDict?.vendorCompany ?? "-/-"
            modelShippingMen?.receiverType = invoiceDetailsDict?.vendorCompanyType ?? "-/-"
            modelShippingMen?.receiverContact = invoiceDetailsDict?.vendorPhone ?? "-/-"
            modelShippingMen?.receiverLicense = invoiceDetailsDict?.vendorLicenseNumber ?? "-/-"
            modelShippingMen?.receiverAddress = modelAddress
            
            manifestDetailController = segue.destination as! ManifestInfoTableViewController
            manifestDetailController?.validateFieldsDelegate = self
            manifestDetailController?.isAddManifest = isAddManifest
            manifestDetailController?.modelShippingMen = self.modelShippingMen
            manifestDetailController?.invoiceDetailsDict = self.invoiceDetailsDict
            
        }else if segue.identifier == "ManifestItemSelection" {
            
            itemsToShipController = segue.destination as! CreateManifestItemSelectionVC
            itemsToShipController?.SlectShipItemdelegate = self
            itemsToShipController?.isAddManifest = isAddManifest
            itemsToShipController?.modelInvoice = invoiceDetailsDict
            itemsToShipController?.modelShippingMenifest = self.modelShippingMen
            //itemsToShipController?.remainingItemsList = (invoiceDetailsDict?.remainingProducts)!
            //itemsToShipController?.confirmShippingDelegate = self
        }
    }
    
    func confirmSelectedProducts(modelSelectedProducts: List<ModelRemainingProduct>) {
        
        let shiipingMenifest = manifestDetailController?.getShippingMenifest()
        if isAddManifest {
            shiipingMenifest?.updated = true
            shiipingMenifest?.selectedItems = modelSelectedProducts
        }
        shippiingMenifestConfirm?.confirmShippingMenifest(modelShipping: shiipingMenifest!)
        //shippiingMenifestConfirm?.confirmShippingMenifest()
    }
    
    // MARK: - Validate Delegate
    func doValidateFields() {
        shippingSegmentControler.selectedSegmentIndex = 0
        manifestInfoContainerView.isHidden = false
        itemsToShipContainerView.isHidden = true
        manifestDetailController?.validateFields()
    }
    
    func validateFields() {

    }
}

extension ShippingManifestViewController : protocolCreateManifetsItemselection{
    func createManifestTapped(obj: ModelShipingMenifest) {
        newShipDelaget.confirmShip(objShip: obj)
    }

}
