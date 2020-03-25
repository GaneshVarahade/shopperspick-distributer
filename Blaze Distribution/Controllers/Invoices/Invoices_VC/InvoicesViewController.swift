//
//  InvoicesViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
import RealmSwift
import Realm
import QRCodeReader
import AVFoundation
class InvoicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,QRCodeReaderViewControllerDelegate {
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()

    var filtered : [ModelInvoice] = []
    var valueDataObj : [ModelInvoice]!
    var modelInvoice: [ModelInvoice]?
    @IBOutlet weak var invoiceSegmentController: UISegmentedControl!
    @IBOutlet weak var invoicesSearchBar: UISearchBar!
    @IBOutlet weak var invoiceTableView: UITableView!
    @IBOutlet weak var dueDateTitle: UILabel!
    @IBOutlet weak var scanInvoiceBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //for refresh control
        if #available(iOS 10.0, *) {
            invoiceTableView.refreshControl = refreshControl
        } else {
            invoiceTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action:#selector(refreshButtonTapped), for: .valueChanged)
        
        self.tabBarController?.selectedIndex = 1
        invoiceTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        setSearchBarUI()
    }
    
    @objc func refreshButtonTapped(){
        //SyncService.sharedInstance().syncData()
        var afterDate:Int? = nil
        
        if valueDataObj.count > 0{
            afterDate = valueDataObj[0].modified
        }
        SyncService.sharedInstance().getAllInvoices(nil, afterDate){
            (error:PlatformError?) in
            SKActivityIndicator.show(error?.message ?? "Network Error")
            EventBus.sharedBus().publish(.FINISHSYNCINVOICE)
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .FINISHSYNCINVOICE)
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
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .FINISHSYNCDATA)
    }
    
    @objc func syncFinished(_ notification: Notification){
        //Refresh data
        refreshControl.endRefreshing()
        self.manageActivityIndicator(canShow: false)
        getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //call data synch API
         self.view.endEditing(true)
         self.invoicesSearchBar.text = ""
         //SyncService.sharedInstance().syncData()
        
        //call method manage activity indicator
        self.view.bringSubview(toFront: self.activityIndicator)
        self.manageActivityIndicator(canShow:(UserDefaults.standard.bool(forKey: "isSynchStart") && RealmManager().readList(type: ModelInvoice.self).count == 0))
        self.title = NSLocalizedString("InvVcTitle", comment: "")
        
    }
    
    func getData(){
        //valueDataObj =  RealmManager().readList(type: ModelInvoice.self)
        if self.invoiceSegmentController.selectedSegmentIndex==0{
           getOpenInvoices()
        }else{
           getCompleteInvoices()
        }
        invoiceTableView.reloadData()
        print("----DataRead----- \(valueDataObj.count)")
    }
    
    private func getOpenInvoices() {
        valueDataObj = RealmManager().readPredicateAecending(type: ModelInvoice.self, predicate: "!(invoiceStatus = '\(InvoiceStatus.COMPLETED)' && invoicePaymentStatus = 'PAID')")
        //valueDataObj = valueDataObj.filter({ $0.invoicePaymentStatus != "PAID"})
        
        invoiceTableView.reloadData()
    }
    
    private func getCompleteInvoices() {
        valueDataObj = RealmManager().readPredicateAecending(type: ModelInvoice.self, predicate: "invoiceStatus = '\(InvoiceStatus.COMPLETED)' && invoicePaymentStatus = 'PAID'")
        invoiceTableView.reloadData()
    }
    
    // MARK:- Utilities
    func setSearchBarUI() {
        invoicesSearchBar.layer.borderWidth = 1;
        invoicesSearchBar.layer.borderColor = UIColor.white.cgColor
        for s in invoicesSearchBar.subviews[0].subviews {
            if s is UITextField {
                s.layer.borderWidth = 0.5
                s.layer.borderColor = UIColor.APPGreenColor.cgColor
            }
        }
    }
//    @IBAction func BtnLogoutPressed(_ sender: Any) {
//        self.showAlert(title: "", message:NSLocalizedString("confirmLogout", comment: ""), actions:[UIAlertActionStyle.cancel,UIAlertActionStyle.default], closure:{ action in
//        switch action {
//        case .default :
//            print("default")
//            
//            //Delete All Table Data
//            RealmManager().deleteAll(type: ModelInvoice.self)
//            RealmManager().deleteAll(type: ModelInventoryTransfers.self)
//            RealmManager().deleteAll(type: ModelPurchaseOrder.self)
//            RealmManager().deleteAll(type: ModelTimesStampLog.self)
//            RealmManager().deleteAll(type: ModelSignature.self)
//            RealmManager().deleteAll(type: ModelSignatureAsset.self)
//            
//            //pop to login view controller
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
//            UIApplication.shared.keyWindow?.rootViewController = viewController
//            
//        case .cancel :
//            print("cancel")
//            
//        case .destructive :
//            print("Destructive")
//        }
//        
//    })
//        
//    }
    
    //MARK:- Segment Value Change
    @IBAction func invoiceSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            getOpenInvoices()
            dueDateTitle.text       = "DUE DATE"
            scanInvoiceBtn.isHidden = false
            invoiceTableView.reloadData()
        }
        else {
            getCompleteInvoices()
            dueDateTitle.text       = "COMPLETED"
            scanInvoiceBtn.isHidden = true
            invoiceTableView.reloadData()
        }
    }
    // MARK:- UIButton Events
    @IBAction func scanInvoiceBtnPressed(_ sender: Any) {
       startScanning()
    } 
    // MARK:- UITouch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK:- SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filtered.removeAll()
        getData()
        
        for dict in valueDataObj {
            //print(dict)
            //find range of string 
            let invName : NSString! = dict.invoiceNumber! as NSString
            let range = invName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            
            if(range.location != NSNotFound){
               filtered.append(dict)
            }
            
        }
        //print(filtered)
        if !(invoicesSearchBar.text?.count==0)
        {            valueDataObj=filtered
        }else{
            invoicesSearchBar.endEditing(true)
        }
        //print(valueDataObj)
        invoiceTableView.reloadData()
        
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        invoicesSearchBar.endEditing(true)
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        invoicesSearchBar.endEditing(true)
    }

}

extension InvoicesViewController{
    // MARK: - UITableview Datasource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if valueDataObj != nil{
            return valueDataObj.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell                  = tableView.dequeueReusableCell(withIdentifier: "cell") as! InvoicesTableViewCell
        let temp                  = valueDataObj[indexPath.row]
        cell.invoicesNoLabel.text = temp.invoiceNumber
        cell.dueDateLabel.text   =  temp.dueDate?.description
        cell.createdByLabel.text =  temp.salesPerson
        cell.btnInvoiceError.isHidden = true
        
        if let error = temp.putBulkError, error != ""{
           cell.btnInvoiceError.isHidden = false
        }
        // Adda target to error button
        cell.btnInvoiceError.addTarget(self, action: #selector(btnInvoiceClicked(_ :)), for: .touchUpInside)
        cell.btnInvoiceError.tag = indexPath.row
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goInvoiceDetail", sender: self)
        
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
        return (valueDataObj?.count==0 && !UserDefaults.standard.bool(forKey: "isSynchStart")) ? 60.0 : 0.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goInvoiceDetail" {
        
            let nextVC = segue.destination as! InvoiceDetailsTableViewController
            let indexPath = invoiceTableView.indexPathForSelectedRow
            let invoiceObject = valueDataObj[(indexPath?.row)!]
                nextVC.tempData = invoiceObject
        }
    }
    
    @objc func btnInvoiceClicked(_ sender: UIButton) {
        let index:Int = sender.tag
        //Show alert
        let alert = UIAlertController(title: "Error", message: valueDataObj[index].putBulkError, preferredStyle: UIAlertControllerStyle.alert)
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
    
    //MARK : -  QRCOde reder deleaget
    func startScanning() {
        readerVC.delegate = self
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print(result)
        }
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        //scanResultLabel.text = "\(result.value)"
        //let invoiceNumber = "INV-003765"
        self.modelInvoice = RealmManager().readPredicate(type: ModelInvoice.self, predicate: "invoiceNumber = '\(result.value)'")
        afterScan()
        
        dismiss(animated: true, completion: nil)
    }
    
    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if newCaptureDevice.device.localizedName != "" {
            print("Switching capturing to: \(newCaptureDevice.device.localizedName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    func afterScan(){
        if let modelInvoiceList = modelInvoice {
            if modelInvoiceList.count > 0 {
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "InvoiceDetailsTableViewController") as! InvoiceDetailsTableViewController
                obj.tempData = modelInvoice?.first
                self.navigationController?.pushViewController(obj, animated: true)
                
            }else{
                showToast(NSLocalizedString("Inv_noRecords", comment: ""))
            }
        }else{
            showToast(NSLocalizedString("Inv_noRecords", comment: ""))
        }
    }
    
}

// MARK:- Temp Code for prepare invoice

extension InvoicesViewController {
    
    private func prepareInvoice() {
        let request = RequestCreateInvoice()
        
        SKActivityIndicator.show()
        WebServicesAPI.sharedInstance().prepareInvoice(request: request) { (result:ResponseCreateInvoice?, _ error:PlatformError?) in
            DispatchQueue.main.async {
                SKActivityIndicator.dismiss()
            }
            guard error == nil else {
                self.showAlert(title: "Error", message: error?.message ?? "Error", closure:{})
                return
            }
            print("response is >> \(String(describing: result))")
        }
    }
    
    private func createInvoice() {
        let request = RequestCreateInvoice()
        
        SKActivityIndicator.show()
        WebServicesAPI.sharedInstance().createInvoice(request: request) { (result:ResponseCreateInvoice?, _ error:PlatformError?) in
            DispatchQueue.main.async {
                SKActivityIndicator.dismiss()
            }
            guard error == nil else {
                self.showAlert(title: "Error", message: error?.message ?? "Error", closure:{})
                return
            }
            print("response is >> \(String(describing: result))")
        }
    }
}




