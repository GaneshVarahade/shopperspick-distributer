//
//  CreateManifestItemSelectionVC.swift
//  BLAZE Distribution
//
//  Created by Mac on 08/10/19.
//  Copyright © 2019 Fidel iOS. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class CreateManifestItemSelectionVC: UIViewController {
    @IBOutlet weak var manifestItemTableView: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    
    var isAddManifest = Bool()
    var modelInvoice: ModelInvoice!
    var modelShippingMenifest: ModelShipingMenifest!
    var remainingItemsList = List<ModelRemainingProduct>()
    var invoiceSelectedItemList = List<ModelRemainingProduct>()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        remainingItemsList = modelInvoice.remainingProducts
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let obj = segue.destination as! CreateManifestDetailsVC
         obj.invoiceSelectedItemList = invoiceSelectedItemList
         obj.modelShippingMenifest = modelShippingMenifest
         obj.modelInvoice = modelInvoice
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //MARK:- Button Actions
    @IBAction func btnContinueTapped(_ sender: Any) {
        if invoiceSelectedItemList.count > 0{
            //go to next view
            
            
        }else{
            self.showAlert(title: "Distribution", message: "Please select product to proceed further") {
            }
        }
    }
    
    @IBAction func btnCheckBoxTapped(_ sender: Any) {
        let button = sender as! UIButton
        if button.imageView?.image == UIImage(named: "checkbox_unselected"){
            //For select
            button.setImage(UIImage(named: "Checkbox"), for: .normal)
            invoiceSelectedItemList.append(remainingItemsList[button.tag])
        }else{
            //for unselect
            button.setImage(UIImage(named: "checkbox_unselected"), for: .normal)
            invoiceSelectedItemList.remove(at: button.tag)
        }
        
    }
    
}

extension CreateManifestItemSelectionVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remainingItemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.manifestItemTableView.dequeueReusableCell(withIdentifier: "Cell") as! ManifestItemSelectionCell
        cell.btnCheckBox.tag = indexPath.row
         cell.btnCheckBox.setImage(UIImage(named: "checkbox_unselected"), for: .normal)
        if invoiceSelectedItemList.count > 0{
            if invoiceSelectedItemList.contains(remainingItemsList[indexPath.row]){
                cell.btnCheckBox.setImage(UIImage(named: "Checkbox"), for: .normal)
            }
        }
        
        cell.lblProductName.text = remainingItemsList[indexPath.row].productName ?? "--"
        cell.lblRemainingQty.text = "\(remainingItemsList[indexPath.row].remainingQuantity)"
        cell.lblRequestedQty.text = "\(remainingItemsList[indexPath.row].requestQuantity)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
