//
//  BasketViewController.swift
//  shopperspick
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift
class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     var modelCreateTrasfer : ModelCreateTransfer!
     var selectedCartProd: List<ModelCartProduct>!
     var tempDataDict = [[String:Any]]()
     override func viewDidLoad() {
        super.viewDidLoad()
        //Assine selected cart product
        if self.modelCreateTrasfer.slectedProducts.count > 0 {
             self.selectedCartProd = modelCreateTrasfer.slectedProducts
             print(self.selectedCartProd)
        }
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("BsketVcTitle", comment: "")
    }
    func getBatchSkuByProdId(prodId:String?) -> String{
        
        let ProductObj = RealmManager().readPredicate(type: ModelProduct.self, distinct: "productId", predicate:"productId = '\(prodId ?? "")'")
        if ProductObj.count > 0{
            if let Sku = ProductObj[0].sku{
                return Sku
            }else{
                return "--"
            }
        }else{
            return "--"
        }
    }
    // MARK:- UITableviewDatasource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedCartProd?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BasketTableViewCell
        cell.productNameLabel.text = self.selectedCartProd[indexPath.row].name
        cell.productUnits.text = String(format: "%.1f", self.selectedCartProd[indexPath.row].quantity)
        cell.productID.text = getBatchSkuByProdId(prodId: self.selectedCartProd[indexPath.row].batchId ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 150
        }
        else {
            return 80
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
        return (self.selectedCartProd?.count ?? 0)==0 ? 60.0 : 0.0
    }
    
    // MARK: - UIButton Events
    @IBAction func continueBtnPressed(_ sender: Any) {
        //performSegue(withIdentifier: "ConfirmTransferViewController", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ConfirmTransferViewController
        destinationVC?.modelCreateTransfer = self.modelCreateTrasfer
    }
    

}
