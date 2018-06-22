//
//  AddProductViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var invoiceItemsTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    
    var modelInvoice: ModelInvoice!
    var shippingMenifDelegate: ShippingMenifestSelectedItemsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Product"
        
        print("\(modelInvoice.remainingProducts.count)")
        invoiceItemsTableView.delegate =  self
        invoiceItemsTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelInvoice.remainingProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! InvoiceItemsTableViewCell
        
        let product = modelInvoice.remainingProducts[indexPath.row]
        cell.productNameBtn.tag = indexPath.row
        cell.productNameBtn.setTitle("\(product.productName!)", for: .normal)
        cell.batchNoLabel.text = product.productId
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
        if deviceIdiom == .pad {
            return 70
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addProductQuantityShippmentSegue" {
            
            let listRemaining = modelInvoice.remainingProducts
            modelInvoice.selectedItems.removeAll()
            for prod in listRemaining {
                if prod.isSelected {
                    modelInvoice.selectedItems.append(prod.copy() as! ModelRemainingProduct)
                }
            }
            let addQuantity = segue.destination as? QuantityAndBatchViewController
            addQuantity?.modelInvoice = modelInvoice
            addQuantity?.shippingMenifDelegate = shippingMenifDelegate
        }
    }

    @objc func tapOnCell(sender: UITapGestureRecognizer) {
        let senderView = sender.view as? UIView
        print(senderView?.tag)
        
        let product = modelInvoice.remainingProducts[(senderView?.tag)!]
        product.isSelected = !product.isSelected
        
        let cell:InvoiceItemsTableViewCell = invoiceItemsTableView.cellForRow(at: IndexPath.init(row: (senderView?.tag)!, section: 0)) as! InvoiceItemsTableViewCell
        
        if !product.isSelected {
            cell.productNameBtn.setImage(UIImage(named: "checkbox_unselected"), for: .normal)
        }else{
            cell.productNameBtn.setImage(UIImage(named: "Checkbox"), for: .normal)
        }
    }
}
