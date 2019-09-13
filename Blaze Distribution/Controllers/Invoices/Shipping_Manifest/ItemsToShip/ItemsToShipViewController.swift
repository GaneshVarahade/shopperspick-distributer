//
//  ItemsToShipViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

protocol ShippingMenifestSelectedItemsDelegate {
    func changeModelInvoice(shippingManifest:ModelShipingMenifest)
}

protocol validationProtocol {
    func doValidateFields()
}


class ItemsToShipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ShippingMenifestSelectedItemsDelegate {


    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var confirmAllBtn: UIButton!
    @IBOutlet weak var invoiceItemsTableView: UITableView!
    @IBOutlet weak var addItemBtn: UIButton!
    
    var isAddManifest = Bool()
    var modelInvoice: ModelInvoice!
    var modelShippingMenifest: ModelShipingMenifest!
    var remainingItemsList = List<ModelRemainingProduct>()
    var invoiceDetailsDict: ModelInvoice?
    
    var tempDataDict = [[String:Any]]()
    var confirmShippingDelegate: ShippingMenifestConfirmSelectedProductsDelegate?
    
    var validateDelegate: validationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if deviceIdiom == .pad {
            invoiceItemsTableView.estimatedRowHeight = 70.0
        }else{
            invoiceItemsTableView.estimatedRowHeight = 60.0
        }
        
        invoiceItemsTableView.delegate = self
        invoiceItemsTableView.dataSource = self
        
//        if modelShippingMenifest.selectedItems.count > 0 {
//            confirmAllBtn.isEnabled = true
//            confirmAllBtn.backgroundColor = UIColor.orange
//
//        }
//        else {
//            confirmAllBtn.isEnabled = false
//            confirmAllBtn.backgroundColor = UIColor.lightGray
//        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        //print("\(modelInvoice.invoiceNumber)")
        invoiceItemsTableView.reloadData()
        if !isAddManifest {
            addItemBtn.isHidden = true
            confirmAllBtn.isEnabled = false
            confirmAllBtn.backgroundColor = UIColor.lightGray
        }
        else {
            getItemsForInvoice()
        }
    }
    
    // MARK: - Selector method
     func getItemsForInvoice(){
        
        if modelShippingMenifest.selectedItems.count > 0 {
            self.invoiceItemsTableView.reloadData()
            confirmAllBtn.isEnabled = true
            confirmAllBtn.backgroundColor = UIColor.orange
        }
        else {
            confirmAllBtn.isEnabled = false
            confirmAllBtn.backgroundColor = UIColor.lightGray
        }
        
    }
    
    // MARK: - UITableviewDelegate/Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelShippingMenifest!.selectedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
        let product = modelShippingMenifest.selectedItems[indexPath.row]
        
        //cell.productNameBtn.setTitle(product.productName, for: .normal)
        cell.lblProductName.text = product.productName ?? "--"
        cell.batchNoLabel.text = product.productId ?? "--"
        cell.noUnits.text = "\(product.requestQuantity)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addProductViewSegue" {
            let addproductController = segue.destination as? AddProductViewController
            addproductController?.shippingManifest = self.modelShippingMenifest
            addproductController?.remainingItemList = self.remainingItemsList
            addproductController?.shippingMenifDelegate = self
        }
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
//        let mirrored_object = Mirror(reflecting: shiipingMenifest!)
//
//        for (index, attr) in mirrored_object.children.enumerated() {
//            if let propertyName = attr.label as String? {
//                print("Attr \(index): \(propertyName) = \(attr.value)")
//
//                guard let attrValue = attr.value as? String, attrValue != "" else {
//                    shippingSegmentControler.selectedSegmentIndex = 0
//                    manifestInfoViewController?.validateFields()
//                    return
//                }
//            }
//        }
        let signImg = StoreImage.getSavedImage(name: modelShippingMenifest.shippingManifestNo!)
        
        if modelShippingMenifest?.deliveryDate == 0 {
            validateDelegate?.doValidateFields()
        }
        else if modelShippingMenifest?.deliveryTime == 0 {
            validateDelegate?.doValidateFields()
        }
        
        guard let company = modelShippingMenifest.receiverCompany, company != "" else {
            validateDelegate?.doValidateFields()
            return
        }
        guard let type = modelShippingMenifest?.receiverType, type != "" else {
            validateDelegate?.doValidateFields()
            return
        }
        guard let contact = modelShippingMenifest?.receiverContact, contact != "" else {
            validateDelegate?.doValidateFields()
            return
        }
        guard let licence = modelShippingMenifest?.receiverLicense, licence != "" else {
            validateDelegate?.doValidateFields()
            return
        }
        guard let address = modelShippingMenifest?.receiverAddress?.address, address != "" else {
            validateDelegate?.doValidateFields()
            return
        }
        guard let driverName = modelShippingMenifest?.driverName, driverName != "" else {
            validateDelegate?.doValidateFields()
            return
        }
//        guard let driverLicence = modelShippingMenifest?.driverLicenseNumber, driverLicence != "" else {
//            validateDelegate?.doValidateFields()
//            return
//        }
//        guard let vehicleMake = modelShippingMenifest?.vehicleMake, vehicleMake != "" else {
//            validateDelegate?.doValidateFields()
//            return
//        }
//        guard let vehicleModel = modelShippingMenifest?.vehicleModel, vehicleModel != "" else {
//            validateDelegate?.doValidateFields()
//            return
//        }
//        guard let vehicleColor = modelShippingMenifest?.vehicleColor, vehicleColor != "" else {
//            validateDelegate?.doValidateFields()
//            return
//        }
//        guard let driverLicenPlate = modelShippingMenifest?.driverLicenPlate, driverLicenPlate != "" else {
//            validateDelegate?.doValidateFields()
//            return
//        }
        
        
//        guard let img = signImg else {
//            validateDelegate?.doValidateFields()
//            return
//        }
        
        confirmShippingDelegate?.confirmSelectedProducts(modelSelectedProducts: self.modelShippingMenifest.selectedItems)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func changeModelInvoice(shippingManifest:ModelShipingMenifest) {
        self.modelShippingMenifest = shippingManifest
        
        //print("\(modelInvoice.shippingManifests.selectedItems.count)")
    }
}
