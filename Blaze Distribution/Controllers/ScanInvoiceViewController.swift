//
//  ScanInvoiceViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class ScanInvoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Scan Product"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARk:- UIButton Events
    
    @IBAction func proceedBtnPressed(_ sender: Any) {
       // let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InvoiceDetailsTableViewController")
       // self.navigationController?.pushViewController(obj, animated: true)
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
