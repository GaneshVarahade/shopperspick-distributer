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
public enum PyamentType:String{
    case Cash = "CASH"
    case Credit = "CREDIT"
    case Debit = "DEBITE"
    case Checqe = "CHECQ"
}
public class ModelPaymentInfo:ModelBase{
    
    @objc public dynamic var debitCardNo:Int        =   0
    @objc public dynamic var achDate:String?         =   ""
    @objc public dynamic var paymentDate:Int        =   0
    @objc public dynamic var referenceNumber:String = ""
    @objc public dynamic var amount:Double          = 0.0
    @objc public dynamic var notes:String?          = ""
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelPaymentInfo             = ModelPaymentInfo()
        modelPaymentInfo.id              = self.id
        modelPaymentInfo.debitCardNo     = self.debitCardNo
        modelPaymentInfo.achDate         = self.achDate
        modelPaymentInfo.paymentDate     = self.paymentDate
        modelPaymentInfo.referenceNumber = self.referenceNumber
        modelPaymentInfo.amount          = self.amount
        modelPaymentInfo.notes           = self.notes
        modelPaymentInfo.updated         = self.updated
        return modelPaymentInfo
    }
}
