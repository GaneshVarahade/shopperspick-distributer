//
//  InventoryViewController.swift
//  blaze
//
//  Created by pankaj on 04/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topView: UIView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var createBtn: UIButton!
    
    @IBOutlet weak var inventoryTableView: UITableView!
    
    var tempDataList : [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tempDataList = [["name":"Transfer 1","request_no":"123456","date":"04/23/2018"],["name":"Transfer 1","request_no":"123456","date":"04/23/2018"],["name":"Transfer 1","request_no":"123456","date":"04/23/2018"],["name":"Transfer 1","request_no":"123456","date":"04/23/2018"],["name":"Transfer 1","request_no":"123456","date":"04/23/2018"],["name":"Transfer 1","request_no":"123456","date":"04/23/2018"],["name":"Transfer 1","request_no":"123456","date":"04/23/2018"],["name":"Transfer 1","request_no":"123456","date":"04/23/2018"]]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Inventory"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    // MARK:- UISegmentController Valu Changed
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            nameLabel.isHidden = false
            requestLabel.isHidden = false
            dateLabel.isHidden = false
            requestLabel.text = "REQUEST #"
            createBtn.isHidden = false
            inventoryTableView.reloadData()
        }
        else {
            dateLabel.isHidden = true
            requestLabel.text = "QUANTITY"
            createBtn.isHidden = true
            inventoryTableView.reloadData()
        }
    }
    
    
    // MARk:- UITableview DataSource/ Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InventoryTableViewCell
        
        cell.nameLabel.text = (tempDataList[indexPath.row])["name"] as? String
        cell.requestLabel.text = (tempDataList[indexPath.row])["request_no"] as? String
        if segmentControl.selectedSegmentIndex == 0 {
            cell.dateLabel.isHidden = false
            cell.dateLabel.text = (tempDataList[indexPath.row])["date"] as? String
        }
        else {
            cell.dateLabel.isHidden = true
        }
        
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
    
    
     // MARK: - UIButton Events
    
    @IBAction func createTransferBtnPressed(_ sender: Any) {
        //let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateTransferViewController")
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
