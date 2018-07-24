//
//  SettingsVC.swift
//  Blaze Distribution
//
//  Created by Apple on 24/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SettingsVC: UIViewController {

    @IBOutlet weak var btnViewLogs: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnSwitchShop: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SettingTitle", comment: "")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 
    
    @IBAction func btnLogOutClicked(_ sender: Any) {
        
        self.showAlert(title: "", message:NSLocalizedString("confirmLogout", comment: ""), actions:[UIAlertActionStyle.cancel,UIAlertActionStyle.default], closure:{ action in
            switch action {
            case .default :
                print("default")
                
                //Delete All Table Data
                RealmManager().deleteAll(type: ModelInvoice.self)
                RealmManager().deleteAll(type: ModelInventoryTransfers.self)
                RealmManager().deleteAll(type: ModelPurchaseOrder.self)
                RealmManager().deleteAll(type: ModelTimesStampLog.self)
                RealmManager().deleteAll(type: ModelSignature.self)
                RealmManager().deleteAll(type: ModelSignatureAsset.self)
                
                //pop to login view controller
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
                UIApplication.shared.keyWindow?.rootViewController = viewController
                
            case .cancel :
                print("cancel")
                
            case .destructive :
                print("Destructive")
            }
            
        })
    }
    @IBOutlet weak var btnViewLogsClicked: UIButton!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
