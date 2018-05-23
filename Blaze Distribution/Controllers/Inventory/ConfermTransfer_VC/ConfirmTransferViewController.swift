//
//  ConfirmTransferViewController.swift
//  blaze
//
//  Created by pankaj on 09/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class ConfirmTransferViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var transferTableView: UITableView!
    
    var tempDataDict = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //topView.dropShadow()
        
        tempDataDict = [["name":"Product 1","amount":"5 Units","total":"55 Units"],["name":"Product 1","amount":"5 Units","total":"55 Units"],["name":"Product 1","amount":"5 Units","total":"55 Units"],["name":"Product 1","amount":"5 Units","total":"55 Units"],["name":"Product 1","amount":"5 Units","total":"55 Units"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- UITableViewDelegate/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ConfirmTransferTableViewCell
        cell.productNameBtn.setTitle("  \((tempDataDict[indexPath.row])["name"] as? String ?? "No value")", for: .normal)
        cell.transferAmountLbl.text = (tempDataDict[indexPath.row])["amount"] as? String
        cell.expectedTotalLabel.text = (tempDataDict[indexPath.row])["total"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 50
        }
        else {
            return 70
        }
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
