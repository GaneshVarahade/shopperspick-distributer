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

//protocol validationProtocol {
//    func doValidateFields()
//}

class ShippingManifestViewController: UIViewController, ShippingMenifestConfirmSelectedProductsDelegate {

    var invoiceDetailsDict: ModelInvoice?
    var isAddManifest = Bool()
    var modelShippingMen: ModelShipingMenifest?
    var shippiingMenifestConfirm: ShippingMenifestConfirmDelegate?
    
    var manifestDetailController:ManifestInfoTableViewController?
    var itemsToShipController:ItemsToShipViewController?
   
   // var validateDelegate: validationProtocol?
    
    @IBOutlet weak var shippingSegmentControler: UISegmentedControl!
    @IBOutlet weak var itemsToShipContainerView: UIView!
    @IBOutlet weak var manifestInfoContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shippingSegmentControler.selectedSegmentIndex = 1
        manifestInfoContainerView.isHidden = true
        itemsToShipContainerView.isHidden = false
        
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
            manifestInfoContainerView.isHidden = true
            itemsToShipContainerView.isHidden = false
            
        }
    }
    
    func changeUI() {
        shippingSegmentControler.selectedSegmentIndex = 0
        manifestInfoContainerView.isHidden = false
        itemsToShipContainerView.isHidden = true
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
            manifestDetailController?.isAddManifest = isAddManifest
            manifestDetailController?.modelShippingMen = self.modelShippingMen
            
        }else if segue.identifier == "invoiceItemsSegue" {
            
            itemsToShipController = segue.destination as! ItemsToShipViewController
            itemsToShipController?.isAddManifest = isAddManifest
            itemsToShipController?.modelShippingMenifest = self.modelShippingMen
            itemsToShipController?.remainingItemsList = (invoiceDetailsDict?.remainingProducts)!
            itemsToShipController?.confirmShippingDelegate = self
            
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
}
