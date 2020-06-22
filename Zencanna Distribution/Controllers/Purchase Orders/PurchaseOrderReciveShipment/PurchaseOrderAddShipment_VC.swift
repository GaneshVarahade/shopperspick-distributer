//
//  PurchaseOrderAddShipment_VC.swift
//  shopperspick Distribution
//
//  Created by Apple on 28/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit

class PurchaseOrderAddShipment_VC: UIViewController,UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var tBLListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension PurchaseOrderAddShipment_VC {
    
    // MARK: - UITableview Datasource/Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return arrayModelPurchaseOrders.count
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let modelPurcahseOrder = arrayModelPurchaseOrders[indexPath.row]
        
        //let cell = tBLListView.dequeueReusableCell(withIdentifier: "cell") as! ReceiveShipmentTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell") as! ReceiveShipmentTableViewCell
        
        
        //cell.poNoLabel.text = modelPurcahseOrder.purchaseOrderNumber
        
//        if modelPurcahseOrder.isMetRc {
//            cell.metricImg.image = UIImage.init(named: "okGreen")
//        }
//        else {
//            cell.metricImg.image = UIImage()
//        }
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
        
        //performSegue(withIdentifier: "goPurchaseOrderDetail", sender: self)
        
    }
    
}
