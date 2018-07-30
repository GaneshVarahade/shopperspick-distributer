//
//  ProductDetailsVC.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 30/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ProductDetailsVC: UIViewController,UITableViewDataSource{
    @IBOutlet weak var prodDetailsTable: UITableView!
    var selectedProd = ModelProduct()
    var productList:[ModelProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prodDetailsTable.estimatedRowHeight = 60.0
        //Get products by product id
        if let Productid = selectedProd.productId{
            productList = RealmManager().readPredicate(type: ModelProduct.self, predicate: "productId = '\(Productid)'")
        }
        //print(productList)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension ProductDetailsVC{
    //MARK :- Table View data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return productList.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductDetailsCellVC
        //Get shops name by shops id
        //let shopsModel = RealmManager().readPredicate(type: ShopsModel.self, predicate:"id = ")
        cell.lblShopId.text = productList[indexPath.row].shopId
        cell.lblInvetryId.text = productList[indexPath.row].inventoryId
        cell.lblProductQty.text = String(format:"%.1f",productList[indexPath.row].quantity)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
       return UITableViewAutomaticDimension
    }
}
