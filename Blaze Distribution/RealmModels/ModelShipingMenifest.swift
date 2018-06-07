//
//  ModelShipingMenifest.swift
//  CodableRealm
//
//  Created by Apple on 03/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelShipingMenifest:ModelBase {
    
    @objc public var shopId: String?             = ""
    @objc public var invoiceId: String?          = ""
    @objc public var shippingManifestNo: String? = ""
    @objc public var invoiceAmount: Double       = 0.0
    @objc public var invoiceBalanceDue: Double   = 0.0
    @objc public var shippingNo: Int             = 0
    @objc public var deliveryDate : Int          = 0
    @objc public var driverName:String?          = ""
    @objc public var driverLicenseNumber         = 0
    @objc public var driverMake:String?          = ""
    @objc public var driverModel:String?         = ""
    @objc public var driverColor:String?         = ""
    @objc public var driverLicenPlate:String?    = ""
    @objc public var asset:ModelAssets?
    var itemsToShip = List<ModelProduct>()
    open override class func primaryKey() -> String? {
        return "id"
        
    }
   
    public override func copy(with zone: NSZone?) -> Any { 

        let modelShipingMenifest                 = ModelShipingMenifest()
        modelShipingMenifest.id                  = self.id
        modelShipingMenifest.companyId           = self.companyId
        modelShipingMenifest.shopId              = self.shopId
        modelShipingMenifest.invoiceId           = self.invoiceId
        modelShipingMenifest.shippingManifestNo  = self.shippingManifestNo
        modelShipingMenifest.invoiceAmount       = self.invoiceAmount
        modelShipingMenifest.invoiceBalanceDue   = self.invoiceBalanceDue
        modelShipingMenifest.shippingNo          = self.shippingNo
        modelShipingMenifest.deliveryDate        = self.deliveryDate
        modelShipingMenifest.driverName          = self.driverName
        modelShipingMenifest.driverLicenseNumber = self.driverLicenseNumber
        modelShipingMenifest.driverMake          = self.driverMake
        modelShipingMenifest.driverModel         = self.driverModel
        modelShipingMenifest.driverColor         = self.driverColor
        modelShipingMenifest.driverLicenPlate    = self.driverLicenPlate
        modelShipingMenifest.asset               = self.asset
        
        for itos in self.itemsToShip {
            
            modelShipingMenifest.itemsToShip.append(itos.copy() as! ModelProduct)
            
        }
        
        
        return modelShipingMenifest
    }
    
    public func getString() -> String {
        return "id: \(self.id), companyId:\(self.companyId), shopId: \(self.shopId)"
    }
}
