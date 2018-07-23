//
//  ModelSignature.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelSignature:ModelBase{
    
    @objc public dynamic var name:String?
    @objc public dynamic var invoiceId:String? = ""
    @objc public dynamic var shippingMainfestId:String? = ""
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone:NSZone? = nil) -> Any {
        
        let modelSignature = ModelSignature()
        modelSignature.name = self.name
        modelSignature.invoiceId = self.invoiceId
        modelSignature.shippingMainfestId = self.shippingMainfestId
        modelSignature.id = self.id
        modelSignature.updated = self.updated
        return modelSignature
    }
}
