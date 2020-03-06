//
//  InventoryViewController.swift
//  blaze
//
//  Created by pankaj on 04/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var inventoryTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var data : [Any]                     = []
    var modelLogin: LoginModel?
    var inventoryData : [ModelInventoryTransfers] = []
    var productData : [ModelProduct]     = []
    var filteredData:[Any] = []
    var productFlag:Bool                 = false
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        //Setup refresh controll
        //Hide keyboard while table view scroll
        if #available(iOS 10.0, *) {
            inventoryTableView.refreshControl = refreshControl
        } else {
            inventoryTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshControllBtnTapped), for: .valueChanged)
        setSearchBarUI()
        self.inventoryTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
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
        //call sync service
        self.view.endEditing(true)
        self.searchBar.text = ""
        //SyncService.sharedInstance().syncData()
        
        self.searchBar.endEditing(true)
        self.searchBar.text = ""
        
        self.title = NSLocalizedString("InvetryTitle", comment: "")
        //call method manage activity indicator
        self.view.bringSubview(toFront: self.activityIndicator)
        self.manageActivityIndicator(canShow:(UserDefaults.standard.bool(forKey: "isSynchStart") && RealmManager().readList(type: ModelInventoryTransfers.self).count == 0))
        EventBus.sharedBus().subscribe(self, selector: #selector(onDataSynced), eventType: EventBusEventType.FINISHSYNCDATA)
        getData()
    }
    
    @objc func onDataSynced(){
        getData()
    }
    
    @objc func refreshControllBtnTapped(){
      SyncService.sharedInstance().syncData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        data.removeAll()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .FINISHSYNCDATA)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .FINISHSYNCDATA)
    }
    
    @objc func syncFinished(_ notification: Notification){
        //Refresh data
        refreshControl.endRefreshing()
        self.manageActivityIndicator(canShow: false)
        getData()
    }
 
    @IBAction func segmentChanged(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            self.searchBar.endEditing(true)
            self.searchBar.text = ""
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
            self.searchBar.endEditing(true)
            self.searchBar.text = ""
            data.removeAll()
            productFlag        = true
            dateLabel.isHidden = true
            requestLabel.text  = "QUANTITY"
            createBtn.isHidden = true
            data               = productData
            inventoryTableView.reloadData()
        }
    }
    func getData() {
//        https://api.dev.blaze.me/api/v1/mgmt/inventory/inventoryHistory?status=PENDING
        inventoryData = RealmManager().readList(type: ModelInventoryTransfers.self)
        for item:ModelInventoryTransfers in inventoryData{
            UtilPrintLogs.DLog(message: DLogMessage.InventryData.value(), objectToPrint: "id: "+item.id!
                + " | transerNo: "+item.transferNo!)
        }
        inventoryData.reverse()
        
        // added filter to show products only from assigned shops
        self.modelLogin = RealmManager().readList(type: LoginModel.self).first
        if let assignedShopId = modelLogin?.assignedShop {
            //print(assignedShopId.id!)
           // productData   = RealmManager().readList(type: ModelProduct.self,distinct:"productId")
            productData = RealmManager().readPredicate(type: ModelProduct.self, distinct: "productId", predicate:"shopId = '\(assignedShopId.id ?? "")'")
        }
        
        if productFlag {
            data  = productData
        } else {
            data  = inventoryData
        }
        inventoryTableView.reloadData()
        UtilPrintLogs.requestLogs(message:"DataRead", objectToPrint: inventoryData.count)
    }
    
    
     // MARK: - UIButton Events
    @IBAction func createTransferBtnPressed(_ sender: Any) {
      
    }
    
    // MARK:- Utilities
    func setSearchBarUI() {
        self.searchBar.layer.borderWidth = 1;
        self.searchBar.layer.borderColor = UIColor.white.cgColor
        for s in self.searchBar.subviews[0].subviews {
            if s is UITextField {
                s.layer.borderWidth = 0.5
                s.layer.borderColor = UIColor.APPGreenColor.cgColor
            }
        }
    }
    
    //MARK:- SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filteredData.removeAll()
        getData()
        for dict in data {
            let invName : NSString!
            let invId: NSString!
            if productFlag{
                let temp  = dict as! ModelProduct
                invName = temp.name! as NSString
                if(invName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location != NSNotFound){
                   filteredData.append(dict)
                    }
            } else {
                let temp  = dict as! ModelInventoryTransfers
                invName = temp.toInventoryName! as NSString
                invId = temp.transferNo! as NSString
                
                if(invName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location != NSNotFound || invId.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location != NSNotFound){
                    filteredData.append(dict)
                }
            }
        }
        //print(filtered)
        if !(self.searchBar.text?.count==0)
        {            data=filteredData
        }else{
            self.searchBar.endEditing(true)
        }
        //print(valueDataObj)
        inventoryTableView.reloadData()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }

}

extension InventoryViewController{
    
    // MARk:- UITableview DataSource/ Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = inventoryTableView.dequeueReusableCell(withIdentifier: "cell") as! InventoryTableViewCell
        if productFlag {
            let temp                = data[indexPath.row] as! ModelProduct
            cell.nameLabel.text     = temp.name
            cell.requestLabel.text  = String(format: "%.1f", temp.totalQuantity)
            cell.dateLabel.isHidden = true
            cell.btnErrorInvetry.isHidden = true
            cell.accessoryType = .disclosureIndicator
        } else {
            let tempi   = data[indexPath.row] as! ModelInventoryTransfers
            cell.nameLabel.text     = tempi.toInventoryName
            cell.requestLabel.text  = tempi.transferNo
            cell.dateLabel.text     = DateFormatterUtil.format(dateTime: Double(DateIntConvertUtil.convert(dateTime: tempi.modified, type:DateIntConvertUtil.Seconds)),format: DateFormatterUtil.mmddyyyy)
            cell.dateLabel.isHidden = false
            
            cell.btnErrorInvetry.isHidden = true
            if let error = tempi.putBulkError, error != "" {
                cell.btnErrorInvetry.isHidden = false
            }
            // Adda target to error button
            cell.btnErrorInvetry.addTarget(self, action: #selector(btnInvetryErrorClicked(_ :)), for: .touchUpInside)
            cell.btnErrorInvetry.tag = indexPath.row
            cell.accessoryType = .none
            
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
    
    @objc func btnInvetryErrorClicked(_ sender :UIButton) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        var alertStyle = UIAlertControllerStyle.actionSheet
//        if (UIDevice.current.userInterfaceIdiom == .pad) {
//            alertStyle = .alert
//        }
        if productFlag {
        let objModelProd = data[indexPath.row] as! ModelProduct
            if Int(objModelProd.totalQuantity) > 0{
                let objProdDetails = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVCSegue") as! ProductDetailsVC
                objProdDetails.selectedProd = data[indexPath.row] as! ModelProduct
                self.navigationController?.pushViewController(objProdDetails, animated: true)
            }else{
                self.showAlert(title: "Message", message: "Product quntity is 0 , no inventory are found", closure: {})
            }
        } else {
            let objTransferDetails = self.storyboard?.instantiateViewController(withIdentifier: "TransferDetailsVCSegue") as! TransferDetailsViewController
            objTransferDetails.inventoryTransferModel = data[indexPath.row] as! ModelInventoryTransfers
            self.navigationController?.pushViewController(objTransferDetails, animated: true)
            
//            let alertController = UIAlertController(title: nil, message: "Choose an Option", preferredStyle: alertStyle)
//            let transferDetails = UIAlertAction(title: "Transfer Details", style: .default, handler: { (alert: UIAlertAction!) -> Void in
//                //  perform action to view transfer Details
//            })
//            let pendingTransfers = UIAlertAction(title: "Accept Pending Transfers", style: .default, handler: { (alert: UIAlertAction!) -> Void in
//                //  perform action to accept pending transfer
//            })
//            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
//                //  Do something here upon cancellation.
//            })
//            alertController.addAction(transferDetails)
//            alertController.addAction(pendingTransfers)
//            alertController.addAction(cancelAction)
//            self.present(alertController, animated: true, completion: nil)
        }
       
    }
    
}
