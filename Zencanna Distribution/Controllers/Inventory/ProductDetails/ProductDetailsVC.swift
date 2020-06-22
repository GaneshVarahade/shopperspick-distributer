//
//  ProductDetailsVC.swift
//  shopperspick Distribution
//
//  Created by Fidel iOS on 30/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import SKActivityIndicatorView

class ProductDetailsVC: UIViewController,UITableViewDataSource{
    @IBOutlet weak var prodDetailsTable: UITableView!
    var selectedProd = ModelProduct()
    var productList:[ModelProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("prodDetailsTitle", comment: "")
        self.prodDetailsTable.estimatedRowHeight = 60.0
        //Get products by product id
        if let Productid = selectedProd.productId{
            guard ReachabilityManager.shared.networkStatus() else {
              getOfflineProductDetails(prodId: Productid)
                return
            }
            apiGetLatestProductDetails(prodId: Productid)
        }
        //print(productList)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Helper Method
    func getOfflineProductDetails(prodId:String?){
          productList = RealmManager().readPredicate(type: ModelProduct.self, predicate: "productId = '\(prodId ?? "")'")
        self.prodDetailsTable.reloadData()
    }
    
    //Get product details updated info
    func apiGetLatestProductDetails(prodId:String?){
        SKActivityIndicator.show()
        let requestGetProd = RequestProdutById()
        requestGetProd.productId = prodId
        WebServicesAPI.sharedInstance().GetProductById(request: requestGetProd) { (result:ResponseProduct?,error:PlatformError?) in
            if error != nil{
                SKActivityIndicator.dismiss()
                //print(error?.message! ?? "Error")
                UtilPrintLogs.requestLogs(message: DLogMessage.Error.rawValue, objectToPrint:error?.message! ?? "Error" )
                self.getOfflineProductDetails(prodId: prodId)
                return
            }
            SKActivityIndicator.dismiss()
            self.productResultOperation(jsonData: result)
            //print(result!)
        }
    }
    
    func productResultOperation(jsonData:ResponseProduct?){
        //RealmManager.deleteAll(ModelProduct.self)
        if let tempQuantity = jsonData?.quantities{
//                    //Calcualte total quty.
//                    var totoalQt:Int = 0
//                    for qut in tempQuantity{
//                        totoalQt += Int(qut.quantity ?? 0)
//                    }
            
                    //Write product
                    for qut in tempQuantity{
                        let temp  = ModelProduct()
                        temp.id = HexGenerator.sharedInstance().generate()
                        temp.productId = jsonData?.id
                        temp.name = jsonData?.name
                        temp.companyLinkId = jsonData?.companyLinkId
                        temp.shopId = qut.shopId
                        temp.inventoryId = qut.inventoryId
                        temp.quantity = qut.quantity ?? 0
                       // temp.totalQuantity = Double(totoalQt)
                        productList.append(temp)
                    }
            print(productList)
            self.prodDetailsTable.reloadData()
                }
        else{
            print("---Products nil---")
        }
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
        let shopsModel = RealmManager().readPredicate(type: ShopsModel.self, predicate:"id = '\(productList[indexPath.row].shopId ?? "")'")
        let invetryModel = RealmManager().readPredicate(type: ModelInventory.self, predicate: "id = '\(productList[indexPath.row].inventoryId ?? "")'")
        cell.lblShopId.text = shopsModel[0].name ?? productList[indexPath.row].shopId
        if invetryModel.count == 0{
            cell.lblInvetryId.text = productList[indexPath.row].inventoryId
        }else{
        cell.lblInvetryId.text = invetryModel[0].name ?? productList[indexPath.row].inventoryId
        }
//        cell.lblShopId.text = productList[indexPath.row].shopId
//        cell.lblInvetryId.text = productList[indexPath.row].inventoryId
//
        cell.lblProductQty.text = String(format:"%.1f",productList[indexPath.row].quantity)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
       return UITableViewAutomaticDimension
    }
}
