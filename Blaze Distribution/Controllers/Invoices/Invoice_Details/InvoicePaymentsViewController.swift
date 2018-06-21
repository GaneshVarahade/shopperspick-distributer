//
//  InvoicePaymentsViewController.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 14/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import RealmSwift

protocol InvoicePaymentsDetailsDelegate {
    func getDataForInvoicePayments(dataDict:ModelInvoice)
}

class InvoicePaymentsViewController: UIViewController {

    @IBOutlet weak var paymantTableView: UITableView!
    var paymentInvoiceDelegate:InvoicePaymentsDetailsDelegate?
    
    var paymentList  = List<ModelPaymentInfo>()
    override func viewDidLoad() {
        super.viewDidLoad()

      // print(paymentList)
    }
   
}
extension InvoicePaymentsViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = paymantTableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! InvoicePaymentsTableViewCell
        //cell.lblPaymentName = paymentList[indexPath.row].
        cell.lblAmount.text = "$ \(paymentList[indexPath.row].amount)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 70
        }
        else {
            return 50
        }
    }
    
    // MARK: - PaymentDelegate
    
    func getDataForInvoicePayments(dataDict:ModelInvoice) {
        paymentList = dataDict.paymentInfo
        self.paymantTableView.reloadData()
    }
}

