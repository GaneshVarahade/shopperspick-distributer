//
//  TransferDetailsViewController.swift
//  BLAZE Distribution
//
//  Created by Nishant's Mac on 20/11/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class TransferDetailsViewController: UIViewController {
    
    @IBOutlet weak var transferDateLabel: UILabel!
    @IBOutlet weak var fromShopLabel: UILabel!
    @IBOutlet weak var toShopLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var selectedProductsLabel: UILabel!
    @IBOutlet weak var buttonsHeightConstraint: NSLayoutConstraint!
    
    var inventoryTransferModel = ModelInventoryTransfers()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.title = NSLocalizedString("TransferDetailsTitle", comment: "")
        self.title = "#\(inventoryTransferModel.transferNo ?? "")"
        print("inventory transfer >>>> \(inventoryTransferModel)")

        self.addTempProductsForDev()
        self.setDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDetails() {
        transferDateLabel.text = DateFormatterUtil.format(dateTime: Double(DateIntConvertUtil.convert(dateTime: inventoryTransferModel.modified, type:DateIntConvertUtil.Seconds)),format: DateFormatterUtil.yyyyMMdd_HHmm)
        fromShopLabel.text = "Not Available"
        toShopLabel.text = "Not Available"
        // set from shop and from inventory
        if let fromShopName = inventoryTransferModel.fromShopName {
            fromShopLabel.text = fromShopName
            if let fromInventoryName = inventoryTransferModel.fromInventoryName {
                fromShopLabel.text = "\(fromShopName)(\(fromInventoryName))"
            }
        }
        // set to shop and to inventory
        if let toShopName = inventoryTransferModel.toShopName {
            toShopLabel.text = toShopName
            if let toInventoryName = inventoryTransferModel.toInventoryName {
                toShopLabel.text = "\(toShopName)(\(toInventoryName))"
            }
        }
        // selected products label
        if self.inventoryTransferModel.slectedProducts.isEmpty {
            self.selectedProductsLabel.text = "No Selected Products"
        }
        // update transfer status
        self.statusLabel.text = "Unknown"
        if let status = inventoryTransferModel.status {
            self.statusLabel.text = status
        }
        // hide buttons if transfer is already accepted
        buttonsHeightConstraint.constant = self.view.frame.size.height * 0.1
        if inventoryTransferModel.status == "ACCEPTED" || inventoryTransferModel.status == "DENIED" {
            buttonsHeightConstraint.constant = 0
        }
        
    }
    
    func addTempProductsForDev() {
        let modelCartProduct = ModelCartProduct()
        modelCartProduct.name = "product 1"
        modelCartProduct.quantity = 25
        let modelCartProduct1 = ModelCartProduct()
        modelCartProduct1.name = "product 2"
        modelCartProduct1.quantity = 678
        inventoryTransferModel.slectedProducts.append(modelCartProduct)
        inventoryTransferModel.slectedProducts.append(modelCartProduct1)
    }
    
    func updateTransferStatus(status:Bool) {
        let request = RequestUpdateTransferStatus()
        request.transferId = self.inventoryTransferModel.id
        request.status = status
        SKActivityIndicator.show()
        WebServicesAPI.sharedInstance().updateTransferDetailStatus(request: request) { (result:ResponseUpdateTransferStatus?, _ error:PlatformError?) in
            DispatchQueue.main.async {
                SKActivityIndicator.dismiss()
            }
            guard error == nil else {
                self.showAlert(title: "Error", message: error?.details ?? "Error", closure:{})
                return
            }
            // update status
            DispatchQueue.main.async {
                var statusString = "ACCEPTED"
                if status == false {
                    statusString = "DENIED"
                }
                self.inventoryTransferModel.status = statusString
                self.statusLabel.text = statusString
                self.buttonsHeightConstraint.constant = 0
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @IBAction func updateTransferStatusAcion(_ sender: UIButton) {
        var status = false
        if sender.tag == 1 {
            status = true
        }
        // update with status
        self.updateTransferStatus(status: status)
    }
    

}

extension TransferDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryTransferModel.slectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height * 0.08
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "Cell"
        // Register the table view cell class and its reuse id
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // set the text from the data model
        let product = self.inventoryTransferModel.slectedProducts[indexPath.row]
        cell.textLabel?.text = "\(product.name ?? "") - \(product.quantity)g"
        tableView.separatorStyle = .none
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.init(white: 0.97, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.init(white: 0.93, alpha: 1)
        }
        return cell
    }
    
}
