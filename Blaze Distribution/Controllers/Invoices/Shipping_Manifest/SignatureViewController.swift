//
//  SignatureViewController.swift
//  blaze
//
//  Created by pankaj on 11/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

protocol signatureDelegate {
    func getSignatureImg(signImg: UIImage)
}

class SignatureViewController: UIViewController {

    @IBOutlet weak var signatureImgView: UIImageView!
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    var signDelegate:signatureDelegate?
    var modelShippingMen: ModelShipingMenifest?
    var invoiceDetailsDict: ModelInvoice?
    var isAddManifest = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = NSLocalizedString("SignatureVCTitle", comment: "")
        signatureView.layer.borderColor = UIColor.orange.cgColor
        
        if isAddManifest {
            signatureView.isUserInteractionEnabled = true
            agreeBtn.isHidden = false
            clearBtn.isHidden = false
            
            signatureImgView.isHidden = true
            agreeBtn.isEnabled = true
            clearBtn.isEnabled = true
        }
        else {
            signatureImgView.isHidden = false
            signatureView.isUserInteractionEnabled = false
            agreeBtn.isHidden = true
            clearBtn.isHidden = true
            if let signImg = StoreImage.getSavedImage(name: (modelShippingMen?.shippingManifestNo!)!) {
                signatureImgView.image = signImg
            }
            
            if let imageAsset : ModelSignatureAsset = modelShippingMen?.signatureAsset{
                if let url = imageAsset.getNSURL(){
                    self.signatureImgView.imageFromSecureURL(url, placeHolder: "loadingImage")
                }
            }
        }
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
            //signDelegate?.getSignatureImg(signImg: signatureImage)
            
            if StoreImage.saveImage(image: signatureImage, fileName: (modelShippingMen?.shippingManifestNo)!, 0.5) {
                saveModelSignature(imageName:(modelShippingMen?.shippingManifestNo)!)
                self.navigationController?.popViewController(animated: true)
            }
            else {
                showToast(NSLocalizedString("sig_Error", comment:""))
            }
            
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
            self.signatureView.clear()
        }
    }
    
    func saveModelSignature(imageName:String) {
        let objSignature: ModelSignature = ModelSignature()
        objSignature.id = HexGenerator.sharedInstance().generate()
        objSignature.name = imageName
        objSignature.shippingMainfestId = modelShippingMen?.shippingManifestNo
        objSignature.invoiceId = invoiceDetailsDict?.id
        objSignature.updated = true
        RealmManager().write(table: objSignature)
        //print(RealmManager().readList(type: ModelSignature.self))
        UtilPrintLogs.DLog(message:"Signature saved info", objectToPrint: RealmManager().readList(type: ModelSignature.self))
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
