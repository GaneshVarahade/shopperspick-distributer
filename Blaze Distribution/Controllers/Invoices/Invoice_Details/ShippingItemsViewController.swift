//
//  ShippingItemsViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

protocol ShippingItemsDelegate {
    func getDataForShippingItems(dataDict: [[String:Any]])
}

class ShippingItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var shippingItemsDelegate:ShippingItemsDelegate?
    var shippingData = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataForShippingItems(dataDict: [[String:Any]]) {
        print(dataDict)
        //print(displayDetailsDict)
        shippingData = dataDict
    }
    
    
    // MARK: - UITableviewDatasource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shippingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shippingCell") as! ShippingManifestTableViewCell
        cell.shippingId.text = (shippingData[indexPath.row])["id"] as? String
        cell.shippingStatusLabel.text = (shippingData[indexPath.row])["status"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 70
        }
        return 50
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
