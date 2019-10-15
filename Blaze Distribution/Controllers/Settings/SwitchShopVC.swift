//
//  SwitchShopVC.swift
//  Blaze Distribution
//
//  Created by Apple on 24/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SKActivityIndicatorView

class SwitchShopVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var shopsTableView: UITableView!
    @IBOutlet weak var lblMessage: UILabel!
    
    var modelLogin: LoginModel?
    var shopList = [ShopsModel]()
    var selectedShops = [ShopsModel]()
    var assineShopId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shopsTableView.delegate = self
        self.shopsTableView.dataSource = self
        self.shopsTableView.estimatedRowHeight = 60.0
        self.shopsTableView.rowHeight = UITableViewAutomaticDimension
        self.title = NSLocalizedString("SwitchShopTitle", comment: "")
        setValue()
       // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .FINISHSYNCDATA)
        EventBus.sharedBus().subscribe(self, selector: #selector(startSynchData(_ :)), eventType: .STARTSYNCDATA)
    }
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .FINISHSYNCDATA)
        EventBus.sharedBus().unsubscribe(self, eventType: .STARTSYNCDATA)
    }
    
    @objc func startSynchData(_ notification: Notification){
        self.manageSubmitButton(canAllow: !UserDefaults.standard.bool(forKey: "isSynchStart"))
    }
    
    @objc func syncFinished(_ notification: Notification){
        //Synch finished
        self.manageSubmitButton(canAllow: true)
    }
    
    //Hide and show Submit button depends on data is synch or not
    func manageSubmitButton(canAllow:Bool){
        if canAllow{
            btnSubmit.isUserInteractionEnabled = true
            btnSubmit.alpha = 1.0
            lblMessage.isHidden = true
            
        }else{
            btnSubmit.isUserInteractionEnabled = false
            btnSubmit.alpha = 0.4
            lblMessage.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.manageSubmitButton(canAllow:!UserDefaults.standard.bool(forKey: "isSynchStart"))
    }
    
    func setValue(){
        //Read Login Model
        self.modelLogin = RealmManager().readList(type: LoginModel.self).first
        if let shopsModel = modelLogin?.shops{
            self.shopList = Array(shopsModel).filter { $0.appTarget == "Distribution"}
        }
        
        if let assinedShop = modelLogin?.assignedShop{
            assineShopId = assinedShop.id
            //set assined shop selected
            for shop in shopList{
                if shop.id == assineShopId{
                    selectedShops.append(shop)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return modelPurchaseOrder.productReceived.count + 1
        return shopList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  self.shopsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReceiveShipmentTableViewCell
        //var productInShipMent
        cell.lblProduct?.text = self.shopList[indexPath.row].name ?? "--"
    
        //Check Box
        cell.btnCheck.addTarget(self, action: #selector(checkboxClicked(_ :)), for: .touchUpInside)
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.setImage(UIImage(named : "Checkbox"), for: UIControlState.selected)
        cell.btnCheck.setImage(UIImage(named : "checkbox_unselected"), for: UIControlState.normal)
        
        if selectedShops.contains(shopList[indexPath.row]){
            cell.btnCheck.isSelected = true
        }else{
            cell.btnCheck.isSelected = false
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        if deviceIdiom == .pad{
           return 70.0
        }
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    //MARK: - Helper
    @objc func checkboxClicked(_ sender: UIButton) {
        selectedShops.removeAll()
        let index : Int = sender.tag
        sender.isSelected = !sender.isSelected
        selectedShops.append(self.shopList[index])
        self.shopsTableView.reloadData()
    }
    
    
    //MARK: - Button Actions
    @IBAction func btnSubmitClicked(_ sender: Any) {
        
//            guard !UtilRealmData.hasData() else {
//                showAlert(title: "Warning!", message:NSLocalizedString("hasOfflineDataError", comment: ""), closure:{})
//                return
//            }
        
            guard !(assineShopId == selectedShops[0].id) else {
                showToast(NSLocalizedString("sameShopValidation", comment: ""))
                return
            }
        
            //Create Switch request bulk model
            let requestModel = RequestSwitchShop()
            requestModel.shopId = selectedShops[0].id
        
            SKActivityIndicator.show()
            WebServicesAPI.sharedInstance().SwitchShopPostAPI(request: requestModel) {
                (result:ResponseSwitchShop?,error:PlatformError?) in
                
                if error == nil{
                    
                    UtilRealmData.deletAllTables()
                    self.parseResponse(result: result)
                    SKActivityIndicator.dismiss()
                    //Download New Data
                    self.manageSubmitButton(canAllow:false)
                    SyncService.sharedInstance().syncData()
                    
                }else{
                    
                    SKActivityIndicator.dismiss()
                    self.showAlert(title: "Error", message: error?.message ?? "Error", closure:{})
                    return
                    
                }
            }
    }
    
    private func parseResponse(result:ResponseSwitchShop?){
        
        //Write assinedShopId
        if let data = result?.assignedShop{
            let assineShop = AssignedShopModel()
            assineShop.id          = data.id
            assineShop.name        = data.name!
            assineShop.emailAdress = data.emailAdress
            assineShop.shopType    = data.shopType
            assineShop.phoneNumber = data.phoneNumber
            
            self.modelLogin?.assignedShop = assineShop
            RealmManager().write(table: self.modelLogin!)
            
            self.modelLogin = RealmManager().readList(type: LoginModel.self).first
            //print(self.modelLogin ?? "--")
            self.setValue()
            self.showAlert(title: "Message", message:NSLocalizedString("shopSwitchedSucessfuly", comment: ""), closure:{})
        }
    }
    
}
