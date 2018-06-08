//
//  ForgotPasswordViewController.swift
//  blaze
//
//  Created by pankaj on 03/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import KSToastView
class ForgotPasswordViewController: UIViewController{

    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK:- UIButton Events
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        
        if txtEmail.text != " "{
            let request = RequestForgotPassword()
            request.email = txtEmail.text
            WebServicesAPI.sharedInstance().ForgorPasswordAPI(request: request) { (result, error) in
                
                if let err = error{
                    
                    KSToastView.ks_showToast(err.message)
                }
            }
        }
    }
    
    // MARK: - UITedxtField Delegate
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    // MARK: - Touch events
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
