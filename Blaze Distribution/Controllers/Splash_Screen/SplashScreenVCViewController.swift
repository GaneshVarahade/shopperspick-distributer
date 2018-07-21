//
//  SplashScreenVCViewController.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 18/05/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit

class SplashScreenVCViewController: UIViewController {

    // MARK: - Segue Identifire
    let segueID = "goLogin"
    
    //MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Go to Home Page
        
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(self.goLogin),
                             userInfo: nil,
                             repeats: false)
        
        
       // showToast("\(Bundle.main.releaseVersionNumber!) : \(Bundle.main.releaseBuildNumber!)")
       // showToast("\(DistributionConfig.sharedInstance().getAppUrl())")        
        
    }
    
    // MARK: - Navigation.
    
    @objc func goLogin(){
        
        self.performSegue(withIdentifier: self.segueID, sender: self)
        
    }

}
