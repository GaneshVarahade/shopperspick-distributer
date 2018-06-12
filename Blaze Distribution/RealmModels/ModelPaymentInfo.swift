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
    
    @objc public dynamic var debitNo:String?        = ""
    @objc public dynamic var ACHTransfer:String?     = ""
    @objc public dynamic var paymentDate:Int        =   0
    @objc public dynamic var referenceNumber:String = ""
    @objc public dynamic var amount:Double          = 0.0
    @objc public dynamic var notest:String          = ""
    open override class func primaryKey() -> String? {
        return "id"
    }
    
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
