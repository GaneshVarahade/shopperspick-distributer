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
    
    open override class func primaryKey() -> String? {
        return "id"
        
    }
    convenience init(id:String?, companyId:String?,
                     shopId:String?,
                     invoiceId:String?,
                     shippingManifestNo:String?,
                     invoiceAmount:Double,
                     invoiceBalanceDue:Double){

        self.init(id:id,
                  companyId:companyId)
        self.shopId             = shopId
        self.invoiceId          = invoiceId
        self.shippingManifestNo = shippingManifestNo
        self.invoiceAmount      = invoiceAmount
        self.invoiceBalanceDue  = invoiceBalanceDue
    }
    @objc public var shopId: String? = ""
    
    @objc public var invoiceId: String? = ""
    
    @objc public var shippingManifestNo: String? = ""
    
    @objc public var invoiceAmount: Double = 0.0

    @objc public var invoiceBalanceDue: Double = 0.0
    
    public override func copy(with zone: NSZone?) -> Any { 
        
        let modelShipingMenifest = ModelShipingMenifest()
        
        modelShipingMenifest.id = self.id
        modelShipingMenifest.companyId = self.companyId
        modelShipingMenifest.shopId = self.shopId
        modelShipingMenifest.invoiceId = self.invoiceId
        modelShipingMenifest.shippingManifestNo = self.shippingManifestNo
        modelShipingMenifest.invoiceAmount = self.invoiceAmount
        modelShipingMenifest.invoiceBalanceDue = self.invoiceBalanceDue
        
        return modelShipingMenifest
    }
    
    public func getString() -> String {
        return "id: \(self.id), companyId:\(self.companyId), shopId: \(self.shopId)"
    }
}
