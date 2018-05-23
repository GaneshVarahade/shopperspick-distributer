//
//  SignatureViewController.swift
//  blaze
//
//  Created by pankaj on 11/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

protocol signatureDelegate {
    func getSignatureImg(signImg: UIImage)
}

class SignatureViewController: UIViewController {

    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    var signDelegate:signatureDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Collect Signature"
        signatureView.layer.borderColor = UIColor.orange.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- UIButton events
    
    @IBAction func agreeBtnPressed(_ sender: Any) {
        if let signatureImage = self.signatureView.getSignature(scale: 10) {
            
            // Saving signatureImage from the line above to the Photo Roll.
            // The first time you do this, the app asks for access to your pictures.
            //UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            signDelegate?.getSignatureImg(signImg: signatureImage)
            self.navigationController?.popViewController(animated: true)
            
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
            self.signatureView.clear()
        }
    }
    
    @IBAction func clearSignatureBtnPressed(_ sender: Any) {
        signatureView.clear()
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
