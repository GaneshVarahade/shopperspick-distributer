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
    @objc public dynamic var vendorCompany:String?         = ""
    @objc public dynamic var salesPerson:String?         = ""
    @objc public dynamic var contact:String?         = ""
    @objc public dynamic var invoiceStatus:String?
    @objc public dynamic var total:Double           = 0.0
    @objc public dynamic var balanceDue:Double      = 0.0
    
    
    @objc public dynamic var vendorLicenseNumber:String?
    @objc public dynamic var vendorCompanyType:String?
    @objc public dynamic var vendorPhone:String?
    @objc public dynamic var vendorAddress:String?
    @objc public dynamic var vendorCity:String?
    @objc public dynamic var vendorState:String?
    @objc public dynamic var vendorZipcode:String?
    @objc public dynamic var vendorCountry:String?
    
    var remainingProducts = List<ModelRemainingProduct>()
    var items = List<ModelInvoiceItems>()
    //var selectedItems = List<ModelRemainingProduct>()
    
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
        modelInvoice.vendorCompany     = self.vendorCompany
        modelInvoice.salesPerson       = self.salesPerson
        modelInvoice.contact           = self.contact
        modelInvoice.invoiceStatus     = self.invoiceStatus
        modelInvoice.total             = self.total
        modelInvoice.balanceDue        = self.balanceDue
        
        modelInvoice.vendorLicenseNumber = self.vendorLicenseNumber
        modelInvoice.vendorCompanyType = self.vendorCompanyType
        modelInvoice.vendorPhone = self.vendorPhone
        modelInvoice.vendorAddress = self.vendorAddress
        modelInvoice.vendorCity = self.vendorCity
        modelInvoice.vendorState = self.vendorState
        modelInvoice.vendorZipcode = self.vendorZipcode
        modelInvoice.vendorCountry = self.vendorCountry
        modelInvoice.updated = self.updated
        
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
            modelInvoice.items.append(item.copy() as! ModelInvoiceItems)
        }
        
//        for item in self.selectedItems {
//            modelInvoice.selectedItems.append(item.copy() as! ModelRemainingProduct)
//        }

        return modelInvoice
    }
}


