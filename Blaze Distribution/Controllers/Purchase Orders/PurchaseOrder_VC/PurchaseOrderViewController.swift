import UIKit

class PurchaseOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var arrayModelPurchaseOrders : [ModelPurchaseOrder]!
    var completed:Bool = false
    @IBOutlet weak var poSearchBar: UISearchBar!
    @IBOutlet weak var poSegmentController: UISegmentedControl!
    @IBOutlet weak var poTableView: UITableView!
    @IBOutlet weak var lookUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setSearchBarUI()
        arrayModelPurchaseOrders = getPurchaseOrders()
    }

    func getPurchaseOrders() -> [ModelPurchaseOrder]{
        return RealmManager().readList(type: ModelPurchaseOrder.self)
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
        
     //   print(sender.selectedSegmentIndex)
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
            poTableView.reloadData()
        }
        else {
            lookUpBtn.isHidden = true
            poTableView.reloadData()
        }
    }
    
    // MARK:- UITouch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        
        if completed{
            performSegue(withIdentifier: "goDetails", sender: self)
        }else{
            
            return
        }
        
    }
    
}
