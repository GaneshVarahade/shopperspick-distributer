//
//  ViewController.swift
//  CodableRealm
//
//  Created by Apple on 30/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ShipingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getjson()
        print("Hello World")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    private func getjson(){
        
        if let filePath = Bundle.main.path(forResource: "GetAllInvoices", ofType: "txt"){
            let contents = try! String(contentsOfFile: filePath)
            print(contents)
            
            
            let jsonData = contents.data(using: .utf8)//try? JSONSerialization.data(withJSONObject: contents)
            
            if let data = jsonData {
                let responseGellAllInvoices:ResponseGetAllInvoices? = try? JSONDecoder().decode(ResponseGetAllInvoices.self, from: data)
                
                //Print Person Struct
                if let responseGellAllInvoices = responseGellAllInvoices {
                    
                    for responseInvoice in responseGellAllInvoices.values! {
                        
                        //print("From json id: " + (responseInvoice.id)!)
                        let model: ModelInvoice = ModelInvoice()
                        model.id                = responseInvoice.id
                        model.companyId         = responseInvoice.companyId
                        model.shopId            = responseInvoice.shopId
                        model.invoiceNumber     = responseInvoice.invoiceNumber
                        model.customerId        = responseInvoice.customerId
                        
                        if responseInvoice.shippingManifests != nil, responseInvoice.shippingManifests!.count > 0 {
                            //print("From json shipingMenifest: " + (responseInvoice.shippingManifests![0].shippingManifestNo)!)
                            
                            if let shippingManifests = responseInvoice.shippingManifests {
                                
                                for ship in shippingManifests {
                                    let shipMen                 =   ModelShipingMenifest()
                                    shipMen.id                  =   ship.id
                                    shipMen.companyId           =   ship.companyId
                                    shipMen.shopId              =   ship.shopId
                                    shipMen.invoiceId           =   ship.invoiceId
                                    shipMen.shippingManifestNo  =   ship.shippingManifestNo
                                    shipMen.invoiceAmount       =   ship.invoiceAmount ?? 0.0
                                    shipMen.invoiceBalanceDue   =   ship.invoiceBalanceDue ?? 0.0

                                    //print("ModelShpping: "+shipMen.getString())
                                    
                                    model.shippingManifests.append(shipMen)
                                }
                            }
                            
                        }else{
                            print("From json shipingMenifest: Nil")
                        }
                        //print("ModelInvoice: "+model.getString())
                        InvoiceDao().write(table: model)
                       // print("--------------------------")
                        
                    }
                }
            }
        }
    }
}

