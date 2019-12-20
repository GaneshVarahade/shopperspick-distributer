//
//  LoginViewController.swift
//  blaze
//
//  Created by pankaj on 03/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import SKActivityIndicatorView
import KSToastView

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginViewLeading: NSLayoutConstraint!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    @IBOutlet weak var loginViewTrailing: NSLayoutConstraint!
    // MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var labelVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //txtEmail.text       = "test@test.com"
        //txtPassword.text    = "test"
        labelVersion.text   = Versionutils.getAppVersion()
        
    }
    
    //MARK - Layout Helper
    override func viewWillDisappear(_ animated: Bool) {
        EventBus.sharedBus().unsubscribe(self, eventType: EventBusEventType.FINISHSYNCDATA)
//        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//            statusbar.backgroundColor = nil
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        manageLayout()
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        manageLayout()
    }
    
    func manageLayout(){
        // ********** As app is suporting only portrait mode this code is commented for ladscape mode remove this comment **********
//        if deviceIdiom == .pad{
//            if UIDevice.current.orientation.isLandscape{
//                self.loginViewLeading.constant = 260
//                self.loginViewTrailing.constant = 260
//            }else {
//                self.loginViewTrailing.constant = 170
//                self.loginViewLeading.constant = 170
//            }
//        }
    }
    
    // MARK: - IBActions
    @IBAction func loginBtnPressed(_ sender: Any) {
        self.btnForgotPassword.isEnabled = false
        self.btnForgotPassword.alpha = 0.4
        
        SKActivityIndicator.show()
        let reqLogin:RequestLogin = RequestLogin()
        reqLogin.email    = txtEmail.text!
        reqLogin.password = txtPassword.text!
        reqLogin.version  = "2.10.10"
        reqLogin.deviceId = "1F036D8E-1EE4-4C1C-B451-0EA44760344F"
        reqLogin.appTarget = "Distribution"
        
        //print(UIDevice.current.identifierForVendor!.uuidString)
        UtilPrintLogs.requestLogs(message:"Login Info", objectToPrint: UIDevice.current.identifierForVendor!.uuidString)
        WebServicesAPI.sharedInstance().loginAPI(request: reqLogin, onComplition: {(result:ResponseLogin?, error:PlatformError?) in
            
            SKActivityIndicator.show()
            if error != nil {
                self.btnForgotPassword.isEnabled = true
                self.btnForgotPassword.alpha = 1.0
                SKActivityIndicator.dismiss()
                self.showAlert(title: "Error", message: error?.details ?? "Error", closure:{})
                return
            }
            
            self.saveData(jsonData: result)
            UtilityUserDefaults.sharedInstance().saveToken(strToken: (result?.accessToken)!)
           
            SyncService.sharedInstance().syncData()
            EventBus.sharedBus().subscribe(self, selector: #selector(self.goHome), eventType: EventBusEventType.FINISHSYNCDATA)
          
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DistributionDashboardViewController")
            self.navigationController?.pushViewController(dashboardVC, animated: true)

        })
    }
    
    @IBAction func btnForgotPasswordPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController")
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
    

    @objc func goHome(){
        self.btnForgotPassword.isEnabled = true
        self.btnForgotPassword.alpha = 1.0
        self.performSegue(withIdentifier: "goHome", sender: self)
    }
    
    // MARK: - Helper Methods
    func setup(){
//        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//            statusbar.backgroundColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
//        }
    }
    // MARK: - Mapping Login Response to Model Classes 
    func saveData(jsonData:ResponseLogin?){
        
            if let data = jsonData{
                let modelLogin: LoginModel  = LoginModel()
                modelLogin.accessToken      = data.accessToken
                modelLogin.assetAccessToken = data.assetAccessToken
                modelLogin.appTarget        = data.appTarget
                modelLogin.appType          = data.appType
                modelLogin.sessionId        = data.sessionId
            
            //Employee Mapping
            if data.employee != nil{
                modelLogin.employee?.id         = data.employee?.id
                modelLogin.employee?.firstName  = data.employee?.firstName
                modelLogin.employee?.lastName   = data.employee?.lastName
                modelLogin.employee?.pin        = data.employee?.pin
                modelLogin.employee?.roleId     = data.employee?.roleId
                
               
            }else{
                
                //print("Employee data nil")
                UtilPrintLogs.requestLogs(message:"Employee data nil", objectToPrint:nil)
            }
            //AssingShop Mapping
            if let assigndata = data.assignedShop {
                modelLogin.assignedShop?.id          = assigndata.id
                modelLogin.assignedShop?.name        = assigndata.name!
                modelLogin.assignedShop?.emailAdress = assigndata.emailAdress
                modelLogin.assignedShop?.shopType    = assigndata.shopType
                modelLogin.assignedShop?.phoneNumber = assigndata.phoneNumber
                
            }else{
                
                //print("Assigned Shop nil")
                UtilPrintLogs.requestLogs(message: "Assigned Shop nil", objectToPrint: nil)
            }
            //AssingTerminal Mapping
            if let terminalData = data.assignedTerminal{
                modelLogin.assignedTerminal?.id                  = terminalData.id
                modelLogin.assignedTerminal?.active              = terminalData.active!
                modelLogin.assignedTerminal?.shopId              = terminalData.shopId
                modelLogin.assignedTerminal?.assignedInventoryId = terminalData.assignedInventoryId
                modelLogin.assignedTerminal?.currentEmployeeId   = terminalData.currentEmployeeId
            }else{
                
                //print("Assined Terminal nil")
                UtilPrintLogs.requestLogs(message: "Assined Terminal nil", objectToPrint: nil)
            }
            //Address Mapping
            if let  addr = data.assignedShop?.address{
                modelLogin.assignedShop?.address?.id      = addr.id
                modelLogin.assignedShop?.address?.city    = addr.city!
                modelLogin.assignedShop?.address?.address = addr.address
                modelLogin.assignedShop?.address?.state   = addr.state
            }else{
                
                //print("Address nil")
                UtilPrintLogs.requestLogs(message: "Address nil", objectToPrint: nil)
            }
            ///Shops Mapping
            if let shops = data.shops{
                
                for shop in shops{
                let temp = ShopsModel()
                    temp.id = shop.id
                    temp.name = shop.name
                    temp.appTarget = shop.appTarget
                    temp.shopType = shop.shopType
                    modelLogin.shops.append(temp)
                }
                
            }else{
            
                //print("Shops nil")
                UtilPrintLogs.requestLogs(message: "Shops nil", objectToPrint: nil)
            }
                
            RealmManager().write(table: modelLogin)
            UtilPrintLogs.requestLogs(message: "Login Data Save", objectToPrint: nil)
            //print("----Login Data Save----")
        }else{
            UtilPrintLogs.requestLogs(message: "Unable to save data", objectToPrint: nil)
            //print("Unable to save data ...")
        }
    }
}
