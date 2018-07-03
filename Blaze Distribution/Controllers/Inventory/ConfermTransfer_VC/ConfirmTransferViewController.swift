//
//  ConfirmTransferViewController.swift
//  blaze
//
//  Created by pankaj on 09/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift

class ConfirmTransferViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblFromStore: UILabel!
    @IBOutlet weak var lblToStore: UILabel!
    @IBOutlet weak var lblFromInvetory: UILabel!
    @IBOutlet weak var lblToInvetory: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var transferTableView: UITableView!
    var modelCreateTransfer: ModelCreateTransfer!
    var selectedCartProduct: List<ModelCartProduct>!
    var tempDataDict = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transferTableView.estimatedRowHeight = 60
        self.transferTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpInitialValue()
    }
    //MARK:- Helper
    func setUpInitialValue() -> Void {
        //Get selected card product
        if self.modelCreateTransfer.slectedProducts.count > 0 {
            selectedCartProduct = self.modelCreateTransfer.slectedProducts
            print(selectedCartProduct!)
        }
        
        transferTableView.reloadData()
        
        //set value of transfer
        self.lblFromStore.text = self.modelCreateTransfer.fromLocation?.shop?.name
        self.lblToStore.text = self.modelCreateTransfer.toLocation?.shop?.name
        self.lblFromInvetory.text = self.modelCreateTransfer.fromLocation?.inventory?.name
        self.lblToInvetory.text = self.modelCreateTransfer.toLocation?.inventory?.name
    }
    // MARK:- UITableViewDelegate/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedCartProduct?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ConfirmTransferTableViewCell
        cell.lblProductName.text = self.selectedCartProduct[indexPath.row].name
        cell.lblProductQuantity.text = String(format: "%.1f", self.selectedCartProduct[indexPath.row].quantity)
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
