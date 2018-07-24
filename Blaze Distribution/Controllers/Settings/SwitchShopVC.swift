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

class SwitchShopVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var shopsTableView: UITableView!
    
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
        
        //Read Login Model
        self.modelLogin = RealmManager().readList(type: LoginModel.self).first
        if let shopsModel = modelLogin?.shops{
             self.shopList = Array(shopsModel)
            print(self.shopList)
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
       
        
       // Do any additional setup after loading the view.
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
        print(index)
        sender.isSelected = !sender.isSelected
        selectedShops.append(self.shopList[index])
        self.shopsTableView.reloadData()
        print(selectedShops);
    }
    
    
    //MARK: - Button Actions
    @IBAction func btnSubmitClicked(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
