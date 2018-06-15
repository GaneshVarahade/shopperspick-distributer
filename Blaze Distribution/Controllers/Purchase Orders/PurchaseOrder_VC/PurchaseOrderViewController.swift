import UIKit

class PurchaseOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var arrayModelPurchaseOrders : [ModelPurchaseOrder] = []
    var completed:Bool = false
    @IBOutlet weak var poSearchBar: UISearchBar!
    @IBOutlet weak var poSegmentController: UISegmentedControl!
    @IBOutlet weak var poTableView: UITableView!
    @IBOutlet weak var lookUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPurchaseOrdersReceiving()
        setSearchBarUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .SYNCDATA)
    }
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .SYNCDATA)
    }
    
    @objc func syncFinished(_ notification: Notification){
        //Refresh data
        getPurchaseOrdersReceiving()
    }
    
    func getPurchaseOrdersReceiving(){
        arrayModelPurchaseOrders = RealmManager().readPredicate(type: ModelPurchaseOrder.self,
                                       predicate: "status = '\(PurchaseOrderStatus.WaitingShipment.rawValue)'")
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
        self.title = "Purchase Orders"
    }
    
    // MARK:- Utilities
    func setSearchBarUI() {
        poSearchBar.layer.borderWidth = 1;
        poSearchBar.layer.borderColor = UIColor.white.cgColor
        for s in poSearchBar.subviews[0].subviews {
            if s is UITextField {
                s.layer.borderWidth = 0.5
                s.layer.borderColor = UIColor.gray.cgColor
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
        let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LookupPOsViewController")
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // MARK:- SegmentController value changed
    @IBAction func poSegmentControllerValueChanged(_ sender: Any) {
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
            cell.metricImg.image = UIImage.init(named: "okGreen")
        }
        else {
            cell.metricImg.image = UIImage()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goPurchaseOrderDetail", sender: self)
        
    }
    
}
