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
class ItemsToShipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ShippingMenifestSelectedItemsDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var confirmAllBtn: UIButton!
    @IBOutlet weak var invoiceItemsTableView: UITableView!
    @IBOutlet weak var addItemBtn: UIButton!
    
    var isAddManifest = Bool()
    var modelInvoice: ModelInvoice!
    var modelShippingMenifest: ModelShipingMenifest!
    var remainingItemsList = List<ModelRemainingProduct>()
    
    var tempDataDict = [[String:Any]]()
    var confirmShippingDelegate: ShippingMenifestConfirmSelectedProductsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        cell.productNameBtn.setTitle(product.productName, for: .normal)
        cell.batchNoLabel.text = ""
        cell.noUnits.text = "\(product.requestQuantity)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 80
        }
        return 60
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
        confirmShippingDelegate?.confirmSelectedProducts(modelSelectedProducts: self.modelShippingMenifest.selectedItems)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func changeModelInvoice(shippingManifest:ModelShipingMenifest) {
        self.modelShippingMenifest = shippingManifest
        
        //print("\(modelInvoice.shippingManifests.selectedItems.count)")
    }
}
