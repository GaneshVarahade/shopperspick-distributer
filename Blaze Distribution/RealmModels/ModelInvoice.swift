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
     
    @objc public dynamic var shopId: String?
    
    @objc public dynamic var customerId: String?
    
    @objc public dynamic var invoiceNumber: String?
    
    let shippingManifests = List<ModelShipingMenifest>()
    
    open override class func primaryKey() -> String? {
        return "id"
        
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelInvoice = ModelInvoice()

        modelInvoice.id = self.id
        modelInvoice.companyId = self.companyId
        modelInvoice.shopId = self.shopId
        modelInvoice.customerId = self.customerId
        modelInvoice.invoiceNumber = self.invoiceNumber

        for ship in self.shippingManifests {
            modelInvoice.shippingManifests.append(ship.copy() as! ModelShipingMenifest)
        }


        return modelInvoice
    }
    
    public func getString() -> String {
        return "id: \(self.id), companyId: \(self.companyId), invoiceNumber: \(self.invoiceNumber)"
    }
}
