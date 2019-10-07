//
//  AddProductViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class AddProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var invoiceItemsTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    
    //var modelInvoice: ModelInvoice!
    var shippingManifest : ModelShipingMenifest?
    var remainingItemList = List<ModelRemainingProduct>()
    
    var shippingMenifDelegate: ShippingMenifestSelectedItemsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("AddProdVcTitle", comment: "")
        
        //print("\(modelInvoice.remainingProducts.count)")
        invoiceItemsTableView.delegate =  self
        invoiceItemsTableView.dataSource = self
        
        if deviceIdiom == .pad {
            invoiceItemsTableView.estimatedRowHeight = 70.0
        }else{
            invoiceItemsTableView.estimatedRowHeight = 60.0
        }
        
        //This is tempcall
        let onjrequest = RequestGetAllInventory()
        WebServicesAPI.sharedInstance().getAllInventory(request: onjrequest) {
            (response : ResponseGetAllInvetory?,error : PlatformError?) in
            
        }
        
        let requestObj = RequestGetallBatches()
        requestObj.productId = "5d861945dc4f2a042097be64"
            WebServicesAPI.sharedInstance().getAllBtachesByProdId(request: requestObj, onComplition: { (
                response : ResponseGetAllBatches?, error : PlatformError?) in
                print(response)
                let keyArr : Array = response!.values!
                
            
            })
    }

    func getBatchSkuByProdId(prodId:String?) -> String{
        
        let ProductObj = RealmManager().readPredicate(type: ModelProduct.self, distinct: "productId", predicate:"productId = '\(prodId ?? "")'")
        if ProductObj.count > 0{
            if let Sku = ProductObj[0].sku{
                return Sku
            }else{
                return "--"
            }
        }else{
            return "--"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remainingItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
        let product = remainingItemList[indexPath.row]
        cell.productNameBtn.tag = indexPath.row
        //cell.productNameBtn.setTitle("\(product.productName!)", for: .normal)
        cell.lblProductName.text = product.productName ?? "--"
        cell.batchNoLabel.text = getBatchSkuByProdId(prodId: product.productId ?? "")
        cell.noUnits.text = "\(product.remainingQuantity)"
        if !product.isSelected {
            cell.productNameBtn.setImage(UIImage(named: "checkbox_unselected"), for: .normal)
        }else{
            cell.productNameBtn.setImage(UIImage(named: "Checkbox"), for: .normal)
        }
        
        cell.cellTapView.tag = indexPath.row
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnCell(sender:)))
        cell.cellTapView.addGestureRecognizer(tapGesture)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath.row)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addProductQuantityShippmentSegue" {
            
            let listRemaining = remainingItemList
            shippingManifest?.selectedItems.removeAll()
            for prod in listRemaining {
                if prod.isSelected {
                    shippingManifest?.selectedItems.append(prod.copy() as! ModelRemainingProduct)
                }
            }
            let addQuantity = segue.destination as? QuantityAndBatchViewController
            addQuantity?.shippingManifest = shippingManifest
            addQuantity?.remainingItemList = self.remainingItemList
            addQuantity?.shippingMenifDelegate = shippingMenifDelegate
        }
    }

    @objc func tapOnCell(sender: UITapGestureRecognizer) {
        let senderView = sender.view as? UIView
        //print(senderView?.tag)
        
        let product = remainingItemList[(senderView?.tag)!]
        product.isSelected = !product.isSelected
        
        let cell:InvoiceItemsTableViewCell = invoiceItemsTableView.cellForRow(at: IndexPath.init(row: (senderView?.tag)!, section: 0)) as! InvoiceItemsTableViewCell
        
        if !product.isSelected {
            cell.productNameBtn.setImage(UIImage(named: "checkbox_unselected"), for: .normal)
        }else{
            cell.productNameBtn.setImage(UIImage(named: "Checkbox"), for: .normal)
        }
    }
}
