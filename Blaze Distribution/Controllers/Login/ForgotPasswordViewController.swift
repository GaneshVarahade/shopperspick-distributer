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

    @IBOutlet weak var forgotPasswordLeading: NSLayoutConstraint!
    @IBOutlet weak var forgotPasswordTrailing: NSLayoutConstraint!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //manageLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        manageLayout()
        
    }
    //MARK: - Layout Delegate
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        manageLayout()
    }
    func manageLayout(){
        // ********** As app is suporting only portrait mode this code is commented for ladscape mode remove this comment **********
        
//        if deviceIdiom == .pad{
//            if UIDevice.current.orientation.isLandscape{
//                self.forgotPasswordLeading.constant = 240
//                self.forgotPasswordTrailing.constant = 240
//            }else {
//               self.forgotPasswordTrailing.constant = 150
//               self.forgotPasswordLeading.constant = 150
//            }
//        }
    }
    
    // MARK:- UIButton Events
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        
        if (txtEmail.text?.count)! > 0{
            if isValidEmail(testStr: txtEmail.text!){
                let request = RequestForgotPassword()
                request.email = txtEmail.text
                WebServicesAPI.sharedInstance().ForgorPasswordAPI(request: request) { (result, error) in
                    
                    if let err = error{
                        
                        KSToastView.ks_showToast(err.message)
                    }
                }
            }else{
                showToast(NSLocalizedString("ForgotPass_InvalidEmail", comment: ""))
            }
        }else{
            showToast(NSLocalizedString("ForgotPass_EmailEmpty", comment: ""))
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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
