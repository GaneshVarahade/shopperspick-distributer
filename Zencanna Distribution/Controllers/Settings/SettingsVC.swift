//
//  SettingsVC.swift
//  shopperspick Distribution
//
//  Created by Apple on 24/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SKActivityIndicatorView

class SettingsVC: UIViewController {

    @IBOutlet weak var lblCurrentShop: UILabel!
    @IBOutlet weak var btnViewLogs: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnSwitchShop: UIButton!
    @IBOutlet weak var btnRefresh: UIButton!
    @IBOutlet weak var btnViewLogsClicked: UIButton!
    
    // Propertise
    var loginModel:LoginModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("SettingTitle", comment: "")
        
        // Do any additional setup after loading the view.
        //Set  icon image to buttons
        let image = UIImage(named: "LogsImage")?.withRenderingMode(.alwaysTemplate)
        self.btnViewLogs.setImage(image, for: .normal)
        
        let image1 = UIImage(named: "logOut")?.withRenderingMode(.alwaysTemplate)
        self.btnLogout.setImage(image1, for: .normal)
        
        let image2 = UIImage(named: "resync_icon")?.withRenderingMode(.alwaysTemplate)
        self.btnRefresh.setImage(image2, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setCurrentShop()
        
    }
    
    func setCurrentShop(){
        self.loginModel = RealmManager().readList(type: LoginModel.self).first
        if let assinedModel = self.loginModel?.assignedShop{
            lblCurrentShop.text = assinedModel.name
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button Actions
    
    // Logout,delete all user data and navigate user to login VC
    @IBAction func btnLogOutClicked(_ sender: Any) {
        self.showAlert(title: "", message:NSLocalizedString("confirmLogout", comment: ""), actions:[UIAlertActionStyle.cancel,UIAlertActionStyle.default], closure:{ action in
            switch action {
            case .default :
                print("default")
                UtilRealmData.deletAllTables()
                //pop to login view controller
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
                let navigation = UINavigationController(rootViewController:viewController)
                navigation.navigationBar.isHidden = true
                UIApplication.shared.keyWindow?.rootViewController = navigation
                
            case .cancel :
                print("cancel")
                
            case .destructive :
                print("Destructive")
            }
            
        })
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        SKActivityIndicator.show()
        if let realm = try? Realm()
        {
            try! realm.write {
                realm.delete(realm.objects(ModelProduct.self))
            }
        }
        SyncService.sharedInstance().syncData()
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
