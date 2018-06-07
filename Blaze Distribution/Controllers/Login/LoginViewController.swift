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
        reqLogin.email = txtEmail.text!
        reqLogin.password = txtPassword.text!
        reqLogin.version = "2.10.9"
        
        WebServicesAPI.sharedInstance().loginAPI(request: reqLogin, onComplition: {(result:ModelLogin?, error:PlatformError?) in
            
            SKActivityIndicator.dismiss()
            if error != nil {
                
                print(error?.details ?? "Error")
                return
            }
            //AQLog.debug(tag: AQLog.TAG_DATABASE_DATA, text: result?.accessToken ?? "Access nil")
            UserDefaults.standard.set(result?.accessToken, forKey: "ACCESS_TOKEN")
            UserDefaults.standard.synchronize()
            self.performSegue(withIdentifier: "goHome", sender: self)
        })
 
    }
    // MARK: - Helper Methods
    func setup(){
        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbar.backgroundColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        }
    }

}
