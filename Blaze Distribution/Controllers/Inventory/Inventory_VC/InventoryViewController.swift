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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var data : [Any]                     = []
    var inventoryData : [ModelInventoryTransfers] = []
    var productData : [ModelProduct]     = []
    var productFlag:Bool                 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func manageActivityIndicator(canShow:Bool){
        if canShow{
            self.activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }else{
            self.activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = NSLocalizedString("InvetryTitle", comment: "")
        //call method manage activity indicator
        self.view.bringSubview(toFront: self.activityIndicator)
        self.manageActivityIndicator(canShow:(UserDefaults.standard.bool(forKey: "isSynchStart") && RealmManager().readList(type: ModelInventoryTransfers.self).count == 0))
        
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        data.removeAll()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .FINISHSYNCDATA)
    }
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .FINISHSYNCDATA)
    }
    
    @objc func syncFinished(_ notification: Notification){
        //Refresh data
        self.manageActivityIndicator(canShow: false)
        getData()
    }
 
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        let label = UILabel(frame: CGRect(x: 10, y: 20, width: tableView.frame.size.width - 10, height: 60))
        label.text = "Sorry! No Records found."
        label.textColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.center
        view.backgroundColor = UIColor.clear
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (data.count==0 && !UserDefaults.standard.bool(forKey: "isSynchStart")) ? 60.0 : 0.0
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
