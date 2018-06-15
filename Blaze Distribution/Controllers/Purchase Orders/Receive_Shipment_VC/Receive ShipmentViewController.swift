//
//  Receive ShipmentViewController.swift
//  blaze
//
//  Created by Fidel iOS on 16/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
class Receive_ShipmentViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var productsView: UIView!
    
    var modelPurchaseOrder: ModelPurchaseOrder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Received Products"
        //productsView.dropShadow()
    }

    

}

extension Receive_ShipmentViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelPurchaseOrder.productReceived.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  listTableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! ReceiveShipmentTableViewCell
        
        
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
                        let cell =  listTableView.dequeueReusableCell(withIdentifier: "idCellAdd", for: indexPath) as! AddItemTableViewCell
                        return cell
        }
        
        
        return cell
        
    }
    
    
}
