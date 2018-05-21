//
//  LoginViewController.swift
//  blaze
//
//  Created by pankaj on 03/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import Crashlytics
class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginSubView: UIView!
    @IBOutlet weak var loginViewBottomContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbar.backgroundColor = UIColor(red:0.97, green:0.69, blue:0.06, alpha:1.0)
        }
        //loginSubView.dropShadow()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbar.backgroundColor = nil
        }
    }
    
    // MARK: - Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - UIButton Events
    
    @IBAction func forgotBtnPressed(_ sender: Any) {
        let forgotVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordViewController")
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
//        let forgotVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlazeTabBarViewController")
//        self.navigationController?.pushViewController(forgotVC, animated: true)
 
//        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlazeTabBarViewController") as! UITabBarController
//        mainVC.selectedIndex = 0
//        //let navigationController = UINavigationController(rootViewController: mainVC)
//        appDelegate.window?.rootViewController = mainVC
//        appDelegate.window?.makeKeyAndVisible()
//        //self.navigationController?.popToRootViewController(animated: true)
//        self.navigationController?.pushViewController(mainVC, animated: true)
        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "BlazeTabBarViewController") as! UITabBarController
//        UIApplication.shared.keyWindow?.rootViewController = tabBarController
        
        Crashlytics.sharedInstance().crash()
    }
    
    
    // MARK: - Keyboard Animation
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    // MARK: - UITedxtField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
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
