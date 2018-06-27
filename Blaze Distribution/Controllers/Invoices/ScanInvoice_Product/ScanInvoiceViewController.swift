//
//  ScanInvoiceViewController.swift
//  blaze
//
//  Created by pankaj on 07/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class ScanInvoiceViewController: UIViewController,QRCodeReaderViewControllerDelegate {

    var modelInvoice: [ModelInvoice]?
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Scan Product"
        
        self.startScanning()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - Helper
    
    func startScanning() {
        readerVC.delegate = self
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print(result)
        }
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        let invoiceNumber = "INV-003765"
        self.modelInvoice = RealmManager().readPredicate(type: ModelInvoice.self, predicate: "invoiceNumber = '\(invoiceNumber)'")
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
    }
    
    //MARk:- UIButton Events
    
    @IBAction func proceedBtnPressed(_ sender: Any) {
       // let obj = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InvoiceDetailsTableViewController")
       // self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goInvoiceDetail" {
            let obj = segue.destination as! InvoiceDetailsTableViewController
            if let modelInvoiceList = modelInvoice {
                if modelInvoiceList.count > 0 {
                    obj.tempData = modelInvoice?.first
                }
            }
        }
    }
}
