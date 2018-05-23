//
//  ScanLookUpViewController.swift
//  blaze
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class ScanLookUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Create Transfer"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIButton Events
    
    @IBAction func scanBtnPressed(_ sender: Any) {
       // let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScanInvoiceViewController")
       // self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func lookUpBtnPressed(_ sender: Any) {
        //let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LookUpProductViewController")
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
