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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        txtEmail.text = "test@test.com"
        txtPassword.text = "test"
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
        WebServicesAPI.singleToneObject.login(user_Name: txtEmail.text!, password: txtPassword.text!) { (strERROR) in
            if strERROR == "200"{
                SKActivityIndicator.dismiss()
                
                let data = DBManager.sharedInstance.getDataFromDB(object: Login.self)
                
                
                   var item = Login()
                       item = data[3] as! Login
                
                
                   /// let itemedit = item.
                    //    itemedit.accessToken = "Test"
                    //    DBManager.sharedInstance.addData(object: itemedit)
                
                
                
                self.performSegue(withIdentifier: "goHome", sender: self)
            }else if strERROR == "400"{
                KSToastView.ks_showToast("Bad request ")
            }else if strERROR == "401"{
                KSToastView.ks_showToast("Unauthorized user")
            }else{
                KSToastView.ks_showToast("Server error")
            }
        }
    }
    // MARK: - Helper Methods
    func setup(){
        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbar.backgroundColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        }
    }

}
