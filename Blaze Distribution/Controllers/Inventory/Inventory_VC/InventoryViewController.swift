//
//  InventoryViewController.swift
//  blaze
//
//  Created by pankaj on 04/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var inventoryTableView: UITableView!
   
    var data : [Any]                     = []
    var inventoryData : [ModelInventoryTransfers] = []
    var productData : [ModelProduct]     = []
    var productFlag:Bool                 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = NSLocalizedString("InvetryTitle", comment: "")
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        data.removeAll()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .SYNCDATA)
    }
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .SYNCDATA)
    }
    
    @objc func syncFinished(_ notification: Notification){
        //Refresh data
        getData()
    }
    @IBAction func BtnLogoutPressed(_ sender: Any) {
        self.showAlert(title: "", message:NSLocalizedString("confirmLogout", comment: ""), actions:[UIAlertActionStyle.cancel,UIAlertActionStyle.default], closure:{ action in
            switch action {
            case .default :
                print("default")
                
                           //Delete All Table Data
                            RealmManager().deleteAll(type: ModelInvoice.self)
                            RealmManager().deleteAll(type: ModelInventoryTransfers.self)
                            RealmManager().deleteAll(type: ModelPurchaseOrder.self)
                            RealmManager().deleteAll(type: ModelTimesStampLog.self)
                            RealmManager().deleteAll(type: ModelSignature.self)
                            RealmManager().deleteAll(type: ModelSignatureAsset.self)
                
                            //pop to login view controller
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                
            case .cancel :
                print("cancel")
                
            case .destructive :
                print("Destructive")
            }
            
        })
    }
    
    
    
    // MARK:- UISegmentController Valu Changed
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            data.removeAll()
            nameLabel.isHidden    = false
            requestLabel.isHidden = false
            dateLabel.isHidden    = false
            requestLabel.text     = "REQUEST#"
            createBtn.isHidden    = false
            productFlag           = false
            data                  = inventoryData
            inventoryTableView.reloadData()
        }
        else {
            data.removeAll()
            productFlag        = true
            dateLabel.isHidden = true
            requestLabel.text  = "QUANTITY"
            createBtn.isHidden = true
            data               = productData
            inventoryTableView.reloadData()
        }
    }
    func getData(){
        inventoryData = RealmManager().readList(type: ModelInventoryTransfers.self)
        inventoryData.reverse()
        
        productData   = RealmManager().readList(type: ModelProduct.self,distinct:"productId")
        if productFlag{
            data  = productData
        }else{
            data  = inventoryData
        }
        inventoryTableView.reloadData()
        //print("----DataRead----- \(inventoryData.count)")
        UtilPrintLogs.DLog(message:"DataRead", objectToPrint: inventoryData.count)
    }
    
    
     // MARK: - UIButton Events
    @IBAction func createTransferBtnPressed(_ sender: Any) {
      
    }
}

extension InventoryViewController{
    
    // MARk:- UITableview DataSource/ Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = inventoryTableView.dequeueReusableCell(withIdentifier: "cell") as! InventoryTableViewCell
        
        
        
        if productFlag{
            
            let temp                = data[indexPath.row] as! ModelProduct
            cell.nameLabel.text     = temp.name
            cell.requestLabel.text  = String(format: "%.1f", temp.quantity)
            cell.dateLabel.isHidden = true
            cell.btnErrorInvetry.isHidden = true
            
        }else{
            let tempi   = data[indexPath.row] as! ModelInventoryTransfers
            cell.nameLabel.text     = tempi.toInventoryName
            cell.requestLabel.text  = tempi.transferNo
            //cell.dateLabel.text     = DateFormatterUtil.format(dateTime: Double(tempi.modified)/1000,
                                                               //format: DateFormatterUtil.mmddyyyy)
            cell.dateLabel.text     = DateFormatterUtil.format(dateTime: Double(DateIntConvertUtil.convert(dateTime: tempi.modified, type:DateIntConvertUtil.Seconds)),format: DateFormatterUtil.mmddyyyy)
            cell.dateLabel.isHidden = false
            
            cell.btnErrorInvetry.isHidden = true
            if let error = tempi.putBulkError, error != ""{
                cell.btnErrorInvetry.isHidden = false
            }
            // Adda target to error button
            cell.btnErrorInvetry.addTarget(self, action: #selector(btnInvetryErrorClicked(_ :)), for: .touchUpInside)
            cell.btnErrorInvetry.tag = indexPath.row
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 60
        }
        else {
            return 44
        }
    }
    
    @objc func btnInvetryErrorClicked(_ sender :UIButton){
        let index : Int = sender.tag
        let tempi   = data[index] as! ModelInventoryTransfers
        //Show Alert
        let alert = UIAlertController(title: "Error", message: tempi.putBulkError, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                //closure()
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
}
