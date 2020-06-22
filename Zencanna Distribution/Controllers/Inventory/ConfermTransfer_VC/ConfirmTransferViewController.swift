//
//  ConfirmTransferViewController.swift
//  shopperspick
//
//  Created by pankaj on 09/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift
import SKActivityIndicatorView

class ConfirmTransferViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblFromStore: UILabel!
    @IBOutlet weak var lblToStore: UILabel!
    @IBOutlet weak var lblFromInvetory: UILabel!
    @IBOutlet weak var lblToInvetory: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var transferTableView: UITableView!
    var modelCreateTransfer: ModelCreateTransfer!
    var selectedCartProduct: List<ModelCartProduct>!
    var tempDataDict = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("ConfirmTransTitle", comment: "")
        if deviceIdiom == .pad{
            self.transferTableView.estimatedRowHeight = 80
        }else {
            self.transferTableView.estimatedRowHeight = 60
        }
        self.transferTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpInitialValue()
    }
    //MARK:- Helper
    func setUpInitialValue() -> Void {
    
      guard self.modelCreateTransfer != nil else {
          return
        }
        //set value of transfer
        self.lblFromStore.text = self.modelCreateTransfer.fromLocation?.shop?.name
        self.lblToStore.text = self.modelCreateTransfer.toLocation?.shop?.name
        self.lblFromInvetory.text = self.modelCreateTransfer.fromLocation?.inventory?.name
        self.lblToInvetory.text = self.modelCreateTransfer.toLocation?.inventory?.name
       
        //Get selected card product
        selectedCartProduct = self.modelCreateTransfer.slectedProducts
        transferTableView.reloadData()
    }
    
    // MARK:- UITableViewDelegate/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedCartProduct?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ConfirmTransferTableViewCell
        cell.lblProductName.text = self.selectedCartProduct[indexPath.row].name ?? "--"
        cell.lblProductQuantity.text = String(format: "%.1f", self.selectedCartProduct[indexPath.row].quantity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 80
        }
        else {
            return 70
        }
    }
    
    @IBAction func btnSubmitTransferClicked(_ sender: Any) {
        if modelCreateTransfer.slectedProducts.count == 0 {
            showToast(NSLocalizedString("ConfirmTrans_Message", comment: ""))
        }else{
            //get currunt date
            let someDate = Date()
            let timeInterval = someDate.timeIntervalSince1970
            let curruntDate = DateIntConvertUtil.convert(dateTime: Int(timeInterval), type:DateIntConvertUtil.Miliseconds)
           //let curruntDate = Int(timeInterval) * 1000

            let transferNo : Int = RealmManager().readList(type: ModelInventoryTransfers.self).count + 1
            
            
            let modelOpenTransfer: ModelInventoryTransfers = ModelInventoryTransfers()
            // Asign all data
            modelOpenTransfer.id = HexGenerator.sharedInstance().generate()
            modelOpenTransfer.status = InvetoryTransferStatus.Pending.rawValue
            modelOpenTransfer.fromShopName = self.modelCreateTransfer.fromLocation?.shop?.name
            modelOpenTransfer.toShopName = self.modelCreateTransfer.toLocation?.shop?.name
            modelOpenTransfer.fromInventoryName = self.modelCreateTransfer.fromLocation?.inventory?.name
            modelOpenTransfer.toInventoryName = self.modelCreateTransfer.toLocation?.inventory?.name
            modelOpenTransfer.modified = curruntDate
            modelOpenTransfer.transferNo = String(transferNo)
            modelOpenTransfer.updated = true
            for model in modelCreateTransfer.slectedProducts{
                model.id = model.batchId
                modelOpenTransfer.slectedProducts.append(model)
            }
           // modelOpenTransfer.slectedProducts = modelCreateTransfer.slectedProducts
            
            //shop id and name
            modelOpenTransfer.fromShopId = self.modelCreateTransfer.fromLocation?.shop?.id
            modelOpenTransfer.toShopId = self.modelCreateTransfer.toLocation?.shop?.id
            modelOpenTransfer.fromInventoryId = self.modelCreateTransfer.fromLocation?.inventory?.id
            modelOpenTransfer.toInventoryId = self.modelCreateTransfer.toLocation?.inventory?.id
            modelOpenTransfer.completeTransfer = false
            
            RealmManager().write(table: modelOpenTransfer)
            //write log
            UtilWriteLogs.writeLog(timesStamp: UtilWriteLogs.curruntDate, event:activityLogEvent.Inventry.rawValue , objectId: modelOpenTransfer.id, lastSynch:nil)
            //SyncService.sharedInstance().syncData()
            SKActivityIndicator.show()
            SyncService.sharedInstance().callPostAPI { (error : PlatformError?) in
                if error != nil{
                    SKActivityIndicator.dismiss()
                    self.showAlert(title: "Message", message: error?.message ?? NSLocalizedString("ServerError", comment: ""), closure: {})
                }else{
                    SKActivityIndicator.dismiss()
                    SyncService.sharedInstance().syncData()
                    self.showAlert(title: "Message", message: "Saved Successfully!", closure: {
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    self.modelCreateTransfer = nil
                }
            }
            
        }
    }

}
