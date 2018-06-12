//
//  ModelPaymentInfo.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelPaymentInfo:ModelBase{
    
    
    @objc public dynamic var paymentDate:Int        =   0
    @objc public dynamic var referenceNumber:String = ""
    @objc public dynamic var amount:Double          = 0.0
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelPaymentInfo             = ModelPaymentInfo()
        modelPaymentInfo.id              = self.id
        modelPaymentInfo.paymentDate     = self.paymentDate
        modelPaymentInfo.referenceNumber = self.referenceNumber
        modelPaymentInfo.amount          = self.amount
        return modelPaymentInfo
    }
}
