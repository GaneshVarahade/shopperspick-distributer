//
//  Receive ShipmentViewController.swift
//  blaze
//
//  Created by Fidel iOS on 16/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
var showAdd:Bool!
class Receive_ShipmentViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var productsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //productsView.dropShadow()
    }

    

}

extension Receive_ShipmentViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  listTableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! ReceiveShipmentTableViewCell
        
        
        if showAdd {
            
            if indexPath.row == 2{
                
                let cell =  listTableView.dequeueReusableCell(withIdentifier: "idCellAdd", for: indexPath) as! AddItemTableViewCell
                return cell
            }
            
        }
        
        return cell
        
    }
    
    
}
