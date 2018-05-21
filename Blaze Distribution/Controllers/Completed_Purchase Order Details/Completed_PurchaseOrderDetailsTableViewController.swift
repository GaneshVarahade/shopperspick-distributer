//
//  Completed_PurchaseOrderDetailsTableViewController.swift
//  blaze
//
//  Created by Fidel iOS on 16/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class Completed_PurchaseOrderDetailsTableViewController: UITableViewController {

    @IBOutlet weak var shippingDetailsView: UIView!
    @IBOutlet weak var productsView: UIView!
    
    var isMetric = Bool()
    var poNo = String()
    var tempDataDict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationController?.navigationBar.isTranslucent = false
        self.title = poNo
        
        if isMetric {
            tempDataDict = ["shipment_details":["metric_id":"45258","status":"Pending","origin":"Dainkin Farms","received":"04/22/2018 - 3:30"],"products":[["product_name":"Product 1","batch_no":"LLPWQ","quantity":"5 Units"],["product_name":"Product 1","batch_no":"LLPWQ","quantity":"5 Units"],["product_name":"Product 1","batch_no":"LLPWQ","quantity":"5 Units"]]]
        }
        else {
            tempDataDict = ["shipment_details":["status":"Pending","origin":"Dainkin Farms","received":"04/22/2018 - 3:30"],"products":[["product_name":"Product 1","batch_no":"LLPWQ","quantity":"5 Units"],["product_name":"Product 1","batch_no":"LLPWQ","quantity":"5 Units"],["product_name":"Product 1","batch_no":"LLPWQ","quantity":"5 Units"]]]
        }
        
        //shippingDetailsView.dropShadow()
        //productsView.dropShadow()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PO_DETAILS"), object: nil, userInfo: ["data":tempDataDict])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if deviceIdiom == .pad {
                return 70
            }
            else {
                return 50
            }
        case 1:
            if deviceIdiom == .pad {
                if isMetric {
                    return (70 * 5)
                }
                else {
                    return 70 * 5
                }
            }
            else {
                if isMetric {
                    return 50 * 5
                }
                else {
                    return 50 *  5
                }
            }
        case 2:
            if deviceIdiom == .pad {
                return 90
            }
            else {
                return 70
            }
        case 3:
            if deviceIdiom == .pad {
                return CGFloat(80 * (tempDataDict["products"] as? [[String:Any]])!.count)
            }
            else{
                return CGFloat(60 * (tempDataDict["products"] as? [[String:Any]])!.count)
            }
        case 4:
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
