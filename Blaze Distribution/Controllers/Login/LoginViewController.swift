//
//  LoginViewController.swift
//  blaze
//
//  Created by pankaj on 03/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

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
        
        WebServicesAPI.singleToneObject.login(user_Name: txtEmail.text!, password: txtPassword.text!) { (strERROR) in
            
            
            
        }

    }
    // MARK: - Helper Methods
    func setup(){
        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbar.backgroundColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        }
    }

}
