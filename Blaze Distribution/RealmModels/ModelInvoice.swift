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

public class ModelProduct:ModelBase{
    
    @objc public dynamic var name:String?     = ""
    @objc public dynamic var batchId:String?  = ""
    @objc public dynamic var quantity:String? = ""
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelProduct      = ModelProduct()
        modelProduct.name     = self.name
        modelProduct.batchId  = self.batchId
        modelProduct.quantity = self.quantity
        
        return modelProduct
    }
}

public class ModelPaymentInfo:ModelBase{
    
    @objc public dynamic var debitNo:String?        = ""
    @objc public dynamic var ACHTransfer:String     = ""
    @objc public dynamic var paymentDate:String     = ""
    @objc public dynamic var referenceNumber:String = ""
    @objc public dynamic var amount:String          = ""
    @objc public dynamic var notest:String          = ""
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelPaymentInfo             = ModelPaymentInfo()
        modelPaymentInfo.debitNo         = self.debitNo
        modelPaymentInfo.ACHTransfer     = self.ACHTransfer
        modelPaymentInfo.paymentDate     = self.paymentDate
        modelPaymentInfo.referenceNumber = self.referenceNumber
        modelPaymentInfo.amount          = self.amount
        modelPaymentInfo.notest          = self.notest
        return modelPaymentInfo
    }
}
public class ModelAssets:ModelBase{
    @objc public dynamic var iconUrl:String?
    public override func copy(with zone: NSZone? = nil) -> Any {
      let modelAsset = ModelAssets()
      modelAsset.iconUrl = self.iconUrl
      return modelAsset
    }
}

public class ModelSignature:ModelBase{
    
    @objc public dynamic var name:String?
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelSignature = ModelSignature()
            modelSignature.name = self.name
            return modelSignature
    }
}

public class ModelPurchaseOrder:ModelBase{
    @objc public dynamic var purchaseOrderNumber:String? = ""
    @objc public dynamic var isMetRc:String?             = ""
    @objc public dynamic var metrcId:String?             = ""
    @objc public dynamic var status:String?              = ""
    @objc public dynamic var origin:String?              = ""
    @objc public dynamic var received:String?            = ""
    var productInShipment = List<ModelProduct>()
    var productReceived   = List<ModelProductReceived>()
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelPurchaseOrder                 = ModelPurchaseOrder()
        modelPurchaseOrder.purchaseOrderNumber = self.purchaseOrderNumber
        modelPurchaseOrder.isMetRc             = self.isMetRc
        modelPurchaseOrder.metrcId             = self.metrcId
        modelPurchaseOrder.status              = self.status
        modelPurchaseOrder.origin              = self.origin
        modelPurchaseOrder.received            = self.received
        
        for prodInShip in self.productInShipment{
            modelPurchaseOrder.productInShipment.append(prodInShip.copy() as! ModelProduct)
        }
        for prodRcv in self.productReceived{
            modelPurchaseOrder.productReceived.append(prodRcv)
        }
        
        return modelPurchaseOrder
    }
    
}
public class ModelProductReceived:ModelBase{
    @objc public dynamic var name:String?     = ""
    @objc public dynamic var expected:String? = ""
    @objc public dynamic var received:String? = ""
    public override func copy(with zone:NSZone? = nil) -> Any {
        let modelProductReceived = ModelProductReceived()
        
        modelProductReceived.name     = self.name
        modelProductReceived.expected = self.expected
        modelProductReceived.received = self.received
        
        return modelProductReceived
    }
}
public class ModelLocation:ModelBase{
    
    @objc public dynamic var shop:String?       = ""
    @objc public dynamic var inventory:String?  = ""
    public override func copy(with zone:NSZone? = nil) -> Any {
        let modelLocation       = ModelLocation()
        modelLocation.shop      = self.shop
        modelLocation.inventory = self.inventory
        return modelLocation
    }
}
public class ModelProductTransfer:ModelBase{
    @objc public dynamic var name:String?          = ""
    @objc public dynamic var transferAmount:Double = 0.0
    @objc public dynamic var expectedTotal:Double  = 0.0
    public override func copy(with zone:NSZone?    = nil) -> Any {

        let modelProductTransfer            = ModelProductTransfer()
        modelProductTransfer.name           = self.name
        modelProductTransfer.transferAmount = self.transferAmount
        modelProductTransfer.expectedTotal  = self.expectedTotal
        return modelProductTransfer
    }
}
public class ModelTransfer:ModelBase{
    @objc public dynamic var name:String?    = ""
    @objc public dynamic var request:String? = ""
    @objc public dynamic var date:String?    = ""
    @objc public dynamic var fromLocation:ModelLocation?
    @objc public dynamic var toLocation:ModelLocation?
    var product = List<ModelProduct>()
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelTransfer          = ModelTransfer()
        modelTransfer.name         = self.name
        modelTransfer.request      = self.request
        modelTransfer.date         = self.date
        modelTransfer.fromLocation = self.fromLocation
        modelTransfer.toLocation   = self.toLocation
        for prod in self.product{
            
            modelTransfer.product.append(prod.copy() as! ModelProduct)
        }
        return modelTransfer
    }
}

