//
//  TransferDetailsViewController.swift
//  BLAZE Distribution
//
//  Created by Nishant's Mac on 20/11/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import SKActivityIndicatorView

class TransferDetailsViewController: UIViewController {
    
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var createdNameLabel: UILabel!
    @IBOutlet weak var transferDateLabel: UILabel!
    @IBOutlet weak var fromShopLabel: UILabel!
    @IBOutlet weak var toShopLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var selectedProductsLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var statusUpdateAlertLabel: UILabel!
    @IBOutlet weak var denyButton: UIButton!
    @IBOutlet weak var buttonsHeightConstraint: NSLayoutConstraint!
    
    var inventoryTransferModel = ModelInventoryTransfers()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.title = NSLocalizedString("TransferDetailsTitle", comment: "")
        self.title = "#\(inventoryTransferModel.transferNo ?? "")"
        print("inventory transfer >>>> \(inventoryTransferModel)")

        // call custom functions for UI and Data
        self.addTempProductsForDev()
        self.setFonts()
        self.setDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        EventBus.sharedBus().unsubscribe(self, eventType: EventBusEventType.FINISHSYNCDATA)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setFonts() {
        let fontSize = self.view.frame.size.height * 0.02
        createdByLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        createdNameLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        transferDateLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        fromShopLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        toShopLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        statusLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        selectedProductsLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        statusUpdateAlertLabel.font = UIFont.init(name: statusUpdateAlertLabel.font.fontName, size: self.view.frame.size.height * 0.015)
        
        acceptButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        denyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    private func setDetails() {
        createdNameLabel.text = "Unknown"
        if let createdByEmployee = inventoryTransferModel.createdByEmployeeName {
            createdNameLabel.text = createdByEmployee
        }
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
        buttonsHeightConstraint.constant = self.view.frame.size.height * 0.07
        if inventoryTransferModel.status == InvetoryTransferStatus.Accepted.rawValue || inventoryTransferModel.status == InvetoryTransferStatus.Declined.rawValue {
            buttonsHeightConstraint.constant = 0
        } else {
            // when status is pending check if already updated
            if inventoryTransferModel.isStatusUpdated {
                buttonsHeightConstraint.constant = 0
                statusUpdateAlertLabel.isHidden = false
            }
        }
    }
    
    private func addTempProductsForDev() {
        let modelCartProduct = ModelCartProduct()
        modelCartProduct.name = "product 1"
        modelCartProduct.quantity = 25
        let modelCartProduct1 = ModelCartProduct()
        modelCartProduct1.name = "product 2"
        modelCartProduct1.quantity = 678
//        inventoryTransferModel.slectedProducts.append(modelCartProduct)
//        inventoryTransferModel.slectedProducts.append(modelCartProduct1)
    }
    
    private func updateTransferStatus(status:Bool) {
        let request = RequestUpdateTransferStatus()
        request.transferId = self.inventoryTransferModel.id
        request.status = status
        SKActivityIndicator.show()
        WebServicesAPI.sharedInstance().updateTransferDetailStatus(request: request) { (result:ResponseUpdateTransferStatus?, _ error:PlatformError?) in
            DispatchQueue.main.async {
                SKActivityIndicator.dismiss()
            }
            guard error == nil else {
                self.showAlert(title: "Error", message: error?.message ?? "Error", closure:{})
                return
            }
            // refresh data
            SKActivityIndicator.show()
            SyncService.sharedInstance().syncData()
            EventBus.sharedBus().subscribe(self, selector: #selector(self.goHome), eventType: EventBusEventType.FINISHSYNCDATA)
            // update status
            DispatchQueue.main.async {
                // update DB for this transfer
                self.updateTransferModelInDB(status: true)
                // get updated status
                let statusString = result?.status
                // update UI
                self.statusLabel.text = statusString
                self.buttonsHeightConstraint.constant = 0
                self.statusUpdateAlertLabel.isHidden = false
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func goHome(){
        print("syncing done")
        self.statusLabel.text = inventoryTransferModel.status
        if inventoryTransferModel.status != InvetoryTransferStatus.Pending.rawValue {
            self.statusUpdateAlertLabel.isHidden = true
        }
    }
    
    private func updateTransferModelInDB(status:Bool) {
        // get tranfer models and update
        let realm = try! Realm()
        let inventoryData = realm.objects(ModelInventoryTransfers.self)
        for transfer in inventoryData {
            if transfer.id == self.inventoryTransferModel.id {
                try! realm.write {
                    transfer.isStatusUpdated = status
                    realm.add(transfer, update: true)
                }
                break
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
        return self.view.frame.size.height * 0.06
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
