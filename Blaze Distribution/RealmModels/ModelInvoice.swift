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

    @objc public dynamic var shopId: String?         = ""
    @objc public dynamic var customerId: String?     = ""
    @objc public dynamic var invoiceNumber: String?  = ""
    @objc public dynamic var dueDate:String?         = ""
    @objc public dynamic var employeeName:String?    = ""
    @objc public dynamic var duedate:String?         = ""
    @objc public dynamic var company:String?         = ""
    @objc public dynamic var contact:String?         = ""
    @objc public dynamic var total:String?           = ""
    @objc public dynamic var balanceDue:String?      = ""
    @objc public dynamic var receiverCompany:String? = ""
    @objc public dynamic var receiverType:String?    = ""
    @objc public dynamic var receiverContact:String? = ""
    @objc public dynamic var receiverLicense:String? = ""
    @objc public dynamic var receiverAddress:String? = ""
    //var remainingProducts = List<ModelProduct>()
    //var items = List<ModelProduct>()
   // var paymentInfo = List<ModelPaymentInfo>()
    var shippingManifests = List<ModelShipingMenifest>()
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInvoice               = ModelInvoice()
        modelInvoice.id                = self.id
        modelInvoice.companyId         = self.companyId
        modelInvoice.shopId            = self.shopId
        modelInvoice.customerId        = self.customerId
        modelInvoice.invoiceNumber     = self.invoiceNumber
        modelInvoice.dueDate           = self.dueDate
        modelInvoice.employeeName      = self.employeeName
        modelInvoice.company           = self.company
//        modelInvoice.contact           = self.contact
//        modelInvoice.total             = self.total
//        modelInvoice.balanceDue        = self.balanceDue
//        modelInvoice.receiverCompany   = self.receiverCompany
//        modelInvoice.receiverType      = self.receiverType
//        modelInvoice.receiverContact   = self.receiverContact
//        modelInvoice.receiverLicense   = self.receiverLicense
//        modelInvoice.receiverAddress   = self.receiverAddress
       
//        for pay in self.paymentInfo{
//            modelInvoice.paymentInfo.append(pay.copy() as! ModelPaymentInfo)
//        }
        for ship in self.shippingManifests {
            modelInvoice.shippingManifests.append(ship.copy() as! ModelShipingMenifest)
        }
//        for rem in self.remainingProducts{
//            modelInvoice.remainingProducts.append(rem.copy() as! ModelProduct)
//        }
//        for item in self.items{
//            modelInvoice.items.append(item.copy() as! ModelProduct)
//        }
//
        return modelInvoice
    }
    public func getString() -> String {
        return "id: \(self.id), companyId: \(self.companyId), invoiceNumber: \(self.invoiceNumber)"
    }
}


