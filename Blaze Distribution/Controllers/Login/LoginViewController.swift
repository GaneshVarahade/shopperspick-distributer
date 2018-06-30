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

    // MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var labelVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        txtEmail.text       = "test@test.com"
        txtPassword.text    = "test"
        labelVersion.text   = Versionutils.getAppVersion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbar.backgroundColor = nil
        }
    }
 
    // MARK: - IBActions
    @IBAction func loginBtnPressed(_ sender: Any) {
        SKActivityIndicator.show()

        let reqLogin:RequestLogin = RequestLogin()
        reqLogin.email    = txtEmail.text!
        reqLogin.password = txtPassword.text!
        reqLogin.version  = "2.10.10"
        reqLogin.deviceId = "1F036D8E-1EE4-4C1C-B451-0EA44760344F"
        
        print(UIDevice.current.identifierForVendor!.uuidString)
        WebServicesAPI.sharedInstance().loginAPI(request: reqLogin, onComplition: {(result:ResponseLogin?, error:PlatformError?) in
          //  SKActivityIndicator.dismiss()
            if error != nil {
                print(error?.details ?? "Error")
                return
            }
            self.saveData(jsonData: result)
            UtilityUserDefaults.sharedInstance().saveToken(strToken: (result?.accessToken)!)
           
            SKActivityIndicator.show()
            SyncService.sharedInstance().syncData()
            EventBus.sharedBus().subscribe(self, selector: #selector(self.goHome), eventType: EventBusEventType.SYNCDATA)
          
        })
    }

    @objc func goHome(){
        
          self.performSegue(withIdentifier: "goHome", sender: self)
    }
    
    // MARK: - Helper Methods
    func setup(){
        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbar.backgroundColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        }
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
                
                print("Employee data nil")
            }
            //AssingShop Mapping
            if let assigndata = data.assignedShop {
                modelLogin.assignedShop?.id          = assigndata.id
                modelLogin.assignedShop?.name        = assigndata.name!
                modelLogin.assignedShop?.emailAdress = assigndata.emailAdress
                modelLogin.assignedShop?.shopType    = assigndata.shopType
                modelLogin.assignedShop?.phoneNumber = assigndata.phoneNumber
                
            }else{
                
                print("Assigned Shop nil")
            }
            //AssingTerminal Mapping
            if let terminalData = data.assignedTerminal{
                modelLogin.assignedTerminal?.id                  = terminalData.id
                modelLogin.assignedTerminal?.active              = terminalData.active!
                modelLogin.assignedTerminal?.shopId              = terminalData.shopId
                modelLogin.assignedTerminal?.assignedInventoryId = terminalData.assignedInventoryId
                modelLogin.assignedTerminal?.currentEmployeeId   = terminalData.currentEmployeeId
            }else{
                
                print("Assined Terminal nil")
            }
            //Address Mapping
            if let  addr = data.assignedShop?.address{
                modelLogin.assignedShop?.address?.id      = addr.id
                modelLogin.assignedShop?.address?.city    = addr.city!
                modelLogin.assignedShop?.address?.address = addr.address
                modelLogin.assignedShop?.address?.state   = addr.state
            }else{
                
                print("Address nil")
            }
            ///Shops Mapping
            if let shops = data.shops{
                
                for shop in shops{
                let temp = ShopsModel()
                    temp.id = shop.id
                    temp.name = shop.name
                    temp.shopType = shop.shopType
                    modelLogin.shops.append(temp)
                }
                
            }else{
            
                print("Shops nil")
            }
                
            RealmManager().write(table: modelLogin)
            print("----Login Data Save----")
        }else{
            print("Unable to save data ...")
        }
    }
}
