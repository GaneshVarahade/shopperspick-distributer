//
//  ModelInvoice.swift
//  CodableRealm
//
//  Created by Apple on 03/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelInvoice:ModelBase {

  
 
    @objc public dynamic var invoiceNumber: String?  = ""
    @objc public dynamic var dueDate:String?         = ""
    @objc public dynamic var company:String?         = ""
    @objc public dynamic var contact:String?         = ""
    @objc public dynamic var total:Double           = 0.0
    @objc public dynamic var balanceDue:Double      = 0.0
    var remainingProducts = List<ModelRemainingProduct>()
    var items = List<ModelCartProduct>()
    var paymentInfo = List<ModelPaymentInfo>()
    var shippingManifests = List<ModelShipingMenifest>()
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInvoice               = ModelInvoice()
        modelInvoice.id                = self.id
        modelInvoice.companyId         = self.companyId
        modelInvoice.invoiceNumber     = self.invoiceNumber
        modelInvoice.dueDate           = self.dueDate
        modelInvoice.company           = self.company
        modelInvoice.contact           = self.contact
        modelInvoice.total             = self.total
        modelInvoice.balanceDue        = self.balanceDue
        
        for pay in self.paymentInfo{
            modelInvoice.paymentInfo.append(pay.copy() as! ModelPaymentInfo)
        }
        for ship in self.shippingManifests {
            modelInvoice.shippingManifests.append(ship.copy() as! ModelShipingMenifest)
        }
        for rem in self.remainingProducts{
            modelInvoice.remainingProducts.append(rem.copy() as! ModelRemainingProduct)
        }
        for item in self.items{
            modelInvoice.items.append(item.copy() as! ModelCartProduct)
        }

        return modelInvoice
    }
}


