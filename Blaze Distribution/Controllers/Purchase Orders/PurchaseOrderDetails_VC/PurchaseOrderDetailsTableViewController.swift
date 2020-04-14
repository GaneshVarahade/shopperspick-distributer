//
//  PurchaseOrderDetailsTableViewController.swift
//  blaze
//
//  Created by pankaj on 11/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class PurchaseOrderDetailsTableViewController: UITableViewController {

    @IBOutlet weak var shippingDetailsView: UIView!
    @IBOutlet weak var productsView: UIView!
    
    var modelPurcahseOrder: ModelPurchaseOrder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AQLog.debug()

        navigationController?.navigationBar.isTranslucent = false
        self.title = modelPurcahseOrder.purchaseOrderNumber
        
        EventBus.sharedBus().publish(EventBusEventType.SENDATA_PURCHASEORDER, data: ["data":modelPurcahseOrder])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destinationVC = segue.destination as? Receive_ShipmentViewController
            destinationVC?.modelPurchaseOrder = modelPurcahseOrder
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            //case for Header of shipment Details
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 1:
            
            //case for Shipment Details
            if deviceIdiom == .pad {
                
                return (70 * 3)
            }
            else {
                
                return 50 * 3
                
            }
        case 2:
            //case for Header Of ProductList
            if deviceIdiom == .pad {
                return 90
            }
            else {
                return 70
            }
        case 3:
            
            //case for Product List
            if deviceIdiom == .pad {
                return CGFloat(100 * (modelPurcahseOrder.productInShipment.count))
            }
            else{
                return view.frame.height - (self.tabBarController!.tabBar.frame.size.height + 320)
                //return CGFloat(60 * (modelPurcahseOrder.productInShipment.count))+50
            }
        case 4:
            //case for Continue button
            if indexPath.row ==  tableView.numberOfRows(inSection: 0) - 1{
                
                if modelPurcahseOrder.status == PurchaseOrderStatus.Closed.rawValue  ||
                modelPurcahseOrder.status == PurchaseOrderStatus.ReceivedShipment.rawValue {
                    return 0
                }
            }
            
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
            
        default:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        }
    }
 

}
