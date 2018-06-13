//
//  InventoryViewController.swift
//  blaze
//
//  Created by pankaj on 04/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var inventoryTableView: UITableView!

    var inventoryData : [ModelInventory] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Inventory"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
        EventBus.sharedBus().subscribe(self, selector: #selector(syncFinished(_ :)), eventType: .SYNCDATA)
    }
    override func viewDidDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: .SYNCDATA)
    }
    
    @objc func syncFinished(_ notification: Notification){
        //Refresh data
        getData()
    }
    
    @objc func syncComplete(_ notification:NSNotification) {
        SKActivityIndicator.dismiss()
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
    func getData(){
        inventoryData =  RealmManager().readList(type: ModelInventory.self)
        inventoryTableView.reloadData()
        print("----DataRead----- \(inventoryData.count)")
    }
    
   
     // MARK: - UIButton Events
    @IBAction func createTransferBtnPressed(_ sender: Any) {
      
    }
}

extension InventoryViewController{
    
    // MARk:- UITableview DataSource/ Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = inventoryTableView.dequeueReusableCell(withIdentifier: "cell") as! InventoryTableViewCell
        let temp = inventoryData[indexPath.row]
        cell.nameLabel.text    =  temp.toInventoryName
        cell.requestLabel.text =  temp.transferNo
        
        if segmentControl.selectedSegmentIndex == 0 {
            cell.dateLabel.isHidden = false
            cell.dateLabel.text     = String(temp.created)
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
    
}
