//
//  POStaticDetailsTableViewController.swift
//  blaze
//
//  Created by pankaj on 11/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class POStaticDetailsTableViewController: UITableViewController {

    @IBOutlet weak var metricIdLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var receivedLabel: UILabel!
    
    var tempDict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.getDataForPO(notification:)), name: NSNotification.Name(rawValue: "PO_DETAILS"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Selector methods
    @objc func getDataForPO(notification: Notification) {
        tempDict = (notification.userInfo!["data"] as! [String:Any])["shipment_details"] as! [String:Any]
        
        if tempDict["metric_id"] != nil {
            metricIdLabel.text = (tempDict["metric_id"] as! String)
            statusLabel.text = (tempDict["status"] as! String)
            originLabel.text = (tempDict["origin"] as! String)
            receivedLabel.text = (tempDict["received"] as! String)
        }
        else {
            statusLabel.text = (tempDict["status"] as! String)
            originLabel.text = (tempDict["origin"] as! String)
            receivedLabel.text = (tempDict["received"] as! String)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tempDict["metric_id"] != nil {
            return 4
        }
        else {
            return 4
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if tempDict["metric_id"] != nil {
                if deviceIdiom == .pad {
                    return 70
                }
                else {
                    return 50
                }
            }
            else {
                return 0
            }
        }
        else {
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
