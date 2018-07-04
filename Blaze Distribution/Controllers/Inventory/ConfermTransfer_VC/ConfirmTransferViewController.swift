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
    
      guard self.modelCreateTransfer != nil else {
          return
        }
        //set value of transfer
        self.lblFromStore.text = self.modelCreateTransfer.fromLocation?.shop?.name
        self.lblToStore.text = self.modelCreateTransfer.toLocation?.shop?.name
        self.lblFromInvetory.text = self.modelCreateTransfer.fromLocation?.inventory?.name
        self.lblToInvetory.text = self.modelCreateTransfer.toLocation?.inventory?.name
       
        //Get selected card product
        selectedCartProduct = self.modelCreateTransfer.slectedProducts
        print(selectedCartProduct!)
        transferTableView.reloadData()
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
    
    @IBAction func btnSubmitTransferClicked(_ sender: Any) {
        if modelCreateTransfer.slectedProducts.count == 0 {
            showToast("Sorry! No product in cart to submit")
        }else{
            //get currunt date
            let someDate = Date()
            let timeInterval = someDate.timeIntervalSince1970
            let curruntDate = Int(timeInterval) * 1000
            
            //
            let transferNo : Int = RealmManager().readList(type: ModelInventoryTransfers.self).count + 1
            
            
            let modelOpenTransfer: ModelInventoryTransfers = ModelInventoryTransfers()
            // Asign all data
            modelOpenTransfer.id = HexGenerator.sharedInstance().generate()
            modelOpenTransfer.status = InvetryTransferStatus.Pending.rawValue
            modelOpenTransfer.fromShopName = self.modelCreateTransfer.fromLocation?.shop?.name
            modelOpenTransfer.toShopName = self.modelCreateTransfer.toLocation?.shop?.name
            modelOpenTransfer.fromInventoryName = self.modelCreateTransfer.fromLocation?.inventory?.name
            modelOpenTransfer.toInventoryName = self.modelCreateTransfer.toLocation?.inventory?.name
            modelOpenTransfer.modified = curruntDate
            modelOpenTransfer.transferNo = String(transferNo)
            modelOpenTransfer.updated = true
            modelOpenTransfer.slectedProducts = modelCreateTransfer.slectedProducts
            
            RealmManager().write(table: modelOpenTransfer)
            print( RealmManager().readList(type: ModelInventoryTransfers.self).count)
            showAlert(alertTitle: "Message", alertMessage:"Svaed Sucessfuly!", tag: 1)
            modelCreateTransfer = nil
        }
    }
    
    //Mark:- Alert View
    func showAlert(alertTitle:NSString,alertMessage:NSString,tag:Int) -> Void {
        let alert = UIAlertController(title: alertTitle as String, message: alertMessage as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                if tag == 1{
                    //self.navigationController?.popViewControllers(controllersToPop: 2, animated: true)
//                    for controller in self.navigationController!.viewControllers as Array {
//                        if controller.isKind(of: CreateTransferViewController.self) {
//                            self.navigationController!.popToViewController(controller, animated: true)
//                            break
//                        }
//                    }
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
            case .cancel:
                print("cancel")
 
            case .destructive:
                print("destructive")
 
            }}))
        self.present(alert, animated: true, completion: nil)
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
