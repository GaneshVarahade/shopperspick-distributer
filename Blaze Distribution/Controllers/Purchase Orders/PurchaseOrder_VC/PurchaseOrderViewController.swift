import UIKit
import AVFoundation
import QRCodeReader

class PurchaseOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,QRCodeReaderViewControllerDelegate {

    private var arrayModelPurchaseOrders : [ModelPurchaseOrder] = []
    private var arrayFilteredModelPurchaseOrders : [ModelPurchaseOrder] = []
    var completed:Bool = false
    var isBackFromScanView:Bool = false
    @IBOutlet weak var poSearchBar: UISearchBar!
    @IBOutlet weak var poSegmentController: UISegmentedControl!
    @IBOutlet weak var poTableView: UITableView!
    @IBOutlet weak var lookUpBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Refresh control
    var refreshControl = UIRefreshControl()
    
    //Initialize QRCodeScanner
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide keyboard while table view scroll
        if #available(iOS 10.0, *) {
            poTableView.refreshControl = refreshControl
        } else {
            poTableView.addSubview(refreshControl)
        }
        //Add target to ui refresh controller
       
        
        refreshControl.addTarget(self, action: #selector(RefreshControllTapped), for: .valueChanged)
        isBackFromScanView = false
        poTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        getPurchaseOrdersReceiving()
        setSearchBarUI()
    }
    
    @objc func RefreshControllTapped(){
        SyncService.sharedInstance().syncData()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .FINISHSYNCDATA)
    }
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .FINISHSYNCDATA)
    }
    
    @objc func syncFinished(_ notification: Notification){
        //Refresh data
        self.manageActivityIndicator(canShow: false)
        if poSegmentController.selectedSegmentIndex == 0{
            getPurchaseOrdersReceiving()
        }else{
            getPurchaseOrdersCompleted()
        }
        refreshControl.endRefreshing()
        poTableView.reloadData()
    }
    
    func getPurchaseOrdersReceiving(){
        arrayModelPurchaseOrders = RealmManager().readPredicate(type: ModelPurchaseOrder.self,
                                       predicate: "status = '\(PurchaseOrderStatus.ReceivingShipment.rawValue)'")
    }
    func getPurchaseOrdersCompleted(){
        arrayModelPurchaseOrders = RealmManager().readPredicate(type: ModelPurchaseOrder.self,
                                                                predicate: "status = '\(PurchaseOrderStatus.Closed.rawValue)'")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //call method manage activity indicator
        //Load data
        self.view.endEditing(true)
        self.poSearchBar.text = ""
        //SyncService.sharedInstance().syncData()
        
        self.view.bringSubview(toFront: self.activityIndicator)
        self.manageActivityIndicator(canShow:(UserDefaults.standard.bool(forKey: "isSynchStart") && RealmManager().readList(type: ModelPurchaseOrder.self).count == 0))
        
        //if !isBackFromScanView {
            initializePurchaseOrderType()
            poTableView.reloadData()
            poSearchBar.resignFirstResponder()
//        }else{
//            isBackFromScanView = false
//        }
        poSearchBar.text=""
        self.title = NSLocalizedString("PoTitle", comment: "")
        
    }
    
    // MARK:- Utilities
    func setSearchBarUI() {
        poSearchBar.layer.borderWidth = 1;
        poSearchBar.layer.borderColor = UIColor.white.cgColor
        for s in poSearchBar.subviews[0].subviews {
            if s is UITextField {
                s.layer.borderWidth = 0.5
                s.layer.borderColor = UIColor.APPGreenColor.cgColor
            }
        }
    }
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            completed = true
        }else{
            completed = false
        }
    }
    // MARK:- UIButton events
    @IBAction func lookupBtnPressed(_ sender: Any) {
//        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LookupPOsViewController")
//        self.navigationController?.pushViewController(obj, animated: true)
        startScanning()
    }
    
    // MARK:- SegmentController value changed
    @IBAction func poSegmentControllerValueChanged(_ sender: Any) {
        initializePurchaseOrderType()
    }
    //Segment Value Changed
    func initializePurchaseOrderType(){
        if poSegmentController.selectedSegmentIndex == 0 {
            lookUpBtn.isHidden = false
            getPurchaseOrdersReceiving()
            poTableView.reloadData()
        }
        else {
            lookUpBtn.isHidden = true
            getPurchaseOrdersCompleted()
            poTableView.reloadData()
        }
    }
    
    // MARK:- UITouch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    } 

    private func loadCompleted(){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PurchaseOrderDetailsTableViewController,
                let indexPath = poTableView.indexPathForSelectedRow {
                destinationVC.modelPurcahseOrder = arrayModelPurchaseOrders[indexPath.row]
            }
        if let destinationVC = segue.destination as? PurchaseOrderDetailsTableViewController,
            poTableView.indexPathForSelectedRow == nil {
            destinationVC.modelPurcahseOrder = arrayModelPurchaseOrders[0]
        }
    }
    
    //MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
         arrayFilteredModelPurchaseOrders.removeAll()
         initializePurchaseOrderType()
        for dict in arrayModelPurchaseOrders {
            //print(dict)
            //find range of string
            let purchaseOrderNumber : NSString! = dict.purchaseOrderNumber! as NSString
            let range = purchaseOrderNumber.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            if(range.location != NSNotFound){
                arrayFilteredModelPurchaseOrders.append(dict)
            }
        }
        //print(filtered)
        if !(poSearchBar.text?.count==0)
        {   arrayModelPurchaseOrders=arrayFilteredModelPurchaseOrders
        }else{
            poSearchBar.endEditing(true)
        }
        //print(valueDataObj)
            poTableView.reloadData()
            }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        poSearchBar.endEditing(true)
    }
        public func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        poSearchBar.endEditing(true)
    }
    func setUpModelAfterScan(ScannedText : String) -> Void {
        arrayFilteredModelPurchaseOrders.removeAll()
        for dict in arrayModelPurchaseOrders{
            let poNumber : String! = dict.purchaseOrderNumber
            if poNumber.lowercased() == ScannedText.lowercased(){
                arrayFilteredModelPurchaseOrders.append(dict)
//                performSegue(withIdentifier: "goPurchaseOrderDetail", sender: self)
            }
        }
        if arrayFilteredModelPurchaseOrders.count == 0 {
            showToast(NSLocalizedString("PO_Message", comment: ""))
        }else{
            arrayModelPurchaseOrders = arrayFilteredModelPurchaseOrders
            performSegue(withIdentifier: "goPurchaseOrderDetail", sender: self)
            poTableView.reloadData()
        }
       
        
    }
    
    //MARK: - QRCodeReader Delegate
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
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        let scanValue : String = result.value
        guard scanValue.count != 0 else{
        dismiss(animated: true, completion: nil)
            return
        }
        setUpModelAfterScan(ScannedText: scanValue)
        isBackFromScanView = true
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
        isBackFromScanView = true
        dismiss(animated: true, completion: nil)
        //setUpModelAfterScan(ScannedText: "2000-N")
    }
}

extension PurchaseOrderViewController {
    // MARK: - UITableview Datasource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayModelPurchaseOrders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelPurcahseOrder = arrayModelPurchaseOrders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PurchaseOrderTableViewCell
        cell.poNoLabel.text = modelPurcahseOrder.purchaseOrderNumber
        if modelPurcahseOrder.isMetRc {
           // cell.metricImg.image = UIImage.init(named: "okGreen")
            cell.metricLabel.textColor = UIColor.APPGreenColor
            cell.metricLabel.text = "YES"
        }
        else {
           // cell.metricImg.image = UIImage()
            cell.metricLabel.textColor = UIColor.red
            cell.metricLabel.text = "NO"
        }
        
        //Error btn
        cell.btnErrrorPo.isHidden = true
        if let error = modelPurcahseOrder.putBulkError, error != ""{
            cell.btnErrrorPo.isHidden = false
        }
        // Adda target to error button
        cell.btnErrrorPo.addTarget(self, action: #selector(btnPoClicked(_ :)), for: .touchUpInside)
        cell.btnErrrorPo.tag = indexPath.row
        
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
        
        performSegue(withIdentifier: "goPurchaseOrderDetail", sender: self)
        
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
        return (arrayModelPurchaseOrders.count==0 && !UserDefaults.standard.bool(forKey: "isSynchStart")) ? 60.0 : 0.0
    }
    
    @objc func btnPoClicked(_ sender :UIButton){
        let index : Int = sender.tag
        let modelPurcahseOrder = arrayModelPurchaseOrders[index]
        //Show Alert
        let alert = UIAlertController(title: "Error", message: modelPurcahseOrder.putBulkError, preferredStyle: UIAlertControllerStyle.alert)
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
