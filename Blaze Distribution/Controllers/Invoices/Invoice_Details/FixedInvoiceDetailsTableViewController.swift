//
//  FixedInvoiceDetailsTableViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

protocol FixedInvoiceDetailsDelegate {
    func getDataForFixedInvoices(dataDict:ModelInvoice)
}

class FixedInvoiceDetailsTableViewController: UITableViewController {

    @IBOutlet weak var invoiceNoLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    var displayDetailsDict = [String:Any]()
    var fixedInvoiceDelegate:FixedInvoiceDetailsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if deviceIdiom == .pad {
            return 70
        }
        return 50
    }
    
    func getDataForFixedInvoices(data: ModelInvoice) {
        //print(data)
        invoiceNoLabel.text = data.invoiceNumber
        contactLabel.text   = data.contact
        companyLabel.text   = data.vendorCompany
        totalLabel.text     = String(format: "%.2f", data.total)
        balanceLabel.text   = String(format: "%.2f", data.balanceDue)
        dueDateLabel.text   = data.dueDate
        //print(displayDetailsDict)
    }
   

}
