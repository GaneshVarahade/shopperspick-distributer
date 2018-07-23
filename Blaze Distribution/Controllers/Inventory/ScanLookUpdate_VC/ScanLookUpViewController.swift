//
//  ScanLookUpViewController.swift
//  blaze
//
//  Created by pankaj on 08/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import RealmSwift
import  AVFoundation
import QRCodeReader

class ScanLookUpViewController: UIViewController,QRCodeReaderViewControllerDelegate {
    var modelProduct:[ModelProduct] = []
    var modelCreateTransfer: ModelCreateTransfer!
    let customBarbutton = UIButton(type: .system)
    
    //Initialize QRCodeScanner
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //Read model product value
        self.modelProduct = RealmManager().readList(type:ModelProduct.self)
        //print(self.modelProduct)
        
        //SetUp UIBarButton Item
        customBarbutton.setBackgroundImage(UIImage(named: "Basket"), for: (UIControlState.normal))
       // customBarbutton.setTitle("12", for: UIControlState.normal)
        customBarbutton.setTitleColor(UIColor.white, for: UIControlState.normal)
        customBarbutton.sizeToFit()
        customBarbutton.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        customBarbutton.addTarget(self, action: #selector(basketBtnPressed), for: UIControlEvents.touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: customBarbutton)
        self.navigationItem.rightBarButtonItem = rightBarButton

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("ScanlookTitle", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //Set cart counr
        customBarbutton.setTitle(String(self.modelCreateTransfer.slectedProducts.count), for: UIControlState.normal)
    }
   
    //MARK: - QRCodeReader Delegate
    func startScanning() {
        readerVC.delegate = self
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            //print(result)
            UtilPrintLogs.DLog(message: "Scan result", objectToPrint: result)
        }
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        let scanValue : String = result.value
        guard scanValue.count != 0 else{
            dismiss(animated: true, completion: nil)
            return
        }
         setUpModelAfterScan(scannedString: scanValue)
         dismiss(animated: true, completion: nil)
    }
    
    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if newCaptureDevice.device.localizedName != "" {
            print("Switching capturing to: \(newCaptureDevice.device.localizedName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        //setUpModelAfterScan(ScannedText: "2000-N")
    }
    
    //MARK: - Helper
    @objc func basketBtnPressed(){
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
        obj.modelCreateTrasfer = self.modelCreateTransfer
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    func  setUpModelAfterScan(scannedString:String){
         var selecteModelProd: ModelProduct!
        //var found : Bool = false
        if scannedString.isEmpty == false {
            for dict in self.modelProduct{
                let prodId : String = dict.id!
                if prodId.lowercased() == scannedString.lowercased(){
                    selecteModelProd = dict
                    //found = true
                }
            }
            if !(selecteModelProd == nil) {
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "LookUpProductEnterQuantitySegue") as! LookUpProductEnterQuantity
                obj.modelCreateTransfer = self.modelCreateTransfer
                obj.modelProudct = selecteModelProd
                obj.isFromScanView = true
                self.navigationController?.pushViewController(obj, animated: true)
            }else{
                 showToast(NSLocalizedString("ScanProd_Message", comment: ""))
            }
        }else{
            showToast(NSLocalizedString("ScanProd_Message", comment: ""))
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIButton Events
    @IBAction func scanBtnPressed(_ sender: Any) {
      startScanning()
    }
    
    @IBAction func lookUpBtnPressed(_ sender: Any) {
        //let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LookUpProductViewController")
        //self.navigationController?.pushViewController(obj, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let destinationVC = segue.destination as? LookUpProductViewController
       destinationVC?.modelCreateTransfer =  self.modelCreateTransfer

    }
    

}
