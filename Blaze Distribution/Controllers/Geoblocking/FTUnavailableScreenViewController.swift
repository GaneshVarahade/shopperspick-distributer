//
//  FTUnavailableScreenViewController.swift
//  BLAZE Distribution
//
//  Created by Apple on 06/03/20.
//  Copyright © 2020 Fidel iOS. All rights reserved.
//

import UIKit

class FTUnavailableScreenViewController: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    var isNetworkReachable:Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        if !isNetworkReachable{
            lblMessage.text = "Network is not available. Please turn on your cellular data or WiFi."
            btnClose.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCloseBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
