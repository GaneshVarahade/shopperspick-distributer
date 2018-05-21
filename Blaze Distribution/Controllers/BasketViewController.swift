//
//  BasketViewController.swift
//  blaze
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tempDataDict = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Transfer Basket"
        
        tempDataDict = [["name":"Product 1","id":"123245","units":"5 Units"],["name":"Product 1","id":"123245","units":"5 Units"],["name":"Product 1","id":"123245","units":"5 Units"],["name":"Product 1","id":"123245","units":"5 Units"],["name":"Product 1","id":"123245","units":"5 Units"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK:- UITableviewDatasource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BasketTableViewCell
        cell.productNameLabel.text = tempDataDict[indexPath.row]["name"] as? String
        cell.productUnits.text = tempDataDict[indexPath.row]["units"] as? String
        cell.productID.text = tempDataDict[indexPath.row]["id"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 150
        }
        else {
            return 120
        }
    }
    
    // MARK: - UIButton Events
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        //let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfirmTransferViewController")
        //self.navigationController?.pushViewController(obj, animated: true)
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
