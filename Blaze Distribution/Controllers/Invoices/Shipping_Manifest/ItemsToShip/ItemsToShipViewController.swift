//
//  ItemsToShipViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit


protocol ShippingMenifestSelectedItemsDelegate {
    func changeModelInvoice(model:ModelInvoice)
}
class ItemsToShipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ShippingMenifestSelectedItemsDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var confirmAllBtn: UIButton!
    @IBOutlet weak var invoiceItemsTableView: UITableView!
    @IBOutlet weak var addItemBtn: UIButton!
    
    var isAddManifest = Bool()
    var modelInvoice: ModelInvoice!
    
    var tempDataDict = [[String:Any]]()
    var confirmShippingDelegate: ShippingMenifestConfirmDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invoiceItemsTableView.delegate = self
        invoiceItemsTableView.dataSource = self
        
        if modelInvoice.selectedItems.count > 0 {
            confirmAllBtn.isEnabled = true
            confirmAllBtn.backgroundColor = UIColor.orange
        }
        else {
            confirmAllBtn.isEnabled = false
            confirmAllBtn.backgroundColor = UIColor.lightGray
        }
        
        if !isAddManifest {
            addItemBtn.isHidden = true
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        print("\(modelInvoice.invoiceNumber)")
        invoiceItemsTableView.reloadData()
        getItemsForInvoice()
    }
    
    // MARK: - Selector method
     func getItemsForInvoice(){
        
        if modelInvoice.selectedItems.count > 0 {
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
        return modelInvoice.selectedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
        let product = modelInvoice.selectedItems[indexPath.row]
        
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
            addproductController?.modelInvoice = modelInvoice
            addproductController?.shippingMenifDelegate = self
        }
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        confirmShippingDelegate?.confirmShippingMenifest(modelInvoice: modelInvoice)
        self.navigationController?.popViewController(animated: true)
    }
    
    func changeModelInvoice(model: ModelInvoice) {
        self.modelInvoice = model
        
        print("\(modelInvoice.selectedItems.count)")
    }
}
