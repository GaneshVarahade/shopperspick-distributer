//
//  ShippingManifestViewController.swift
//  blaze
//
//  Created by pankaj on 10/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import UIKit

class ShippingManifestViewController: UIViewController{

    var invoiceDetailsDict: ModelInvoice?
    var isAddManifest = Bool()
    
    @IBOutlet weak var shippingSegmentControler: UISegmentedControl!
    @IBOutlet weak var itemsToShipContainerView: UIView!
    @IBOutlet weak var manifestInfoContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shippingSegmentControler.selectedSegmentIndex = 1
        manifestInfoContainerView.isHidden = true
        itemsToShipContainerView.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SegmentControl value changed
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        if shippingSegmentControler.selectedSegmentIndex == 0 {
            manifestInfoContainerView.isHidden = false
            itemsToShipContainerView.isHidden = true
        }
        else {
            manifestInfoContainerView.isHidden = true
            itemsToShipContainerView.isHidden = false
            
        }
    }
    
    // MARK:- ItemsToShip Delegate
    
    func changeUI() {
        shippingSegmentControler.selectedSegmentIndex = 0
        manifestInfoContainerView.isHidden = false
        itemsToShipContainerView.isHidden = true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "manifestDetailsSegue" {
            let vc:ManifestInfoTableViewController = segue.destination as! ManifestInfoTableViewController
            vc.isAddManifest = isAddManifest
            vc.invoiceDetailsDict = self.invoiceDetailsDict
        }
        else if segue.identifier == "invoiceItemsSegue" {
            let vc:ItemsToShipViewController = segue.destination as! ItemsToShipViewController
            vc.isAddManifest = isAddManifest
        }
    }
}
