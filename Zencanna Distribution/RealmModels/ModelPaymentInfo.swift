//
//  ModelPaymentInfo.swift
//  shopperspick Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
public enum PyamentType:String {
    case Cash = "CASH"
    case Credit = "CREDIT"
    case Debit = "DEBITE"
    case Checqe = "CHEQUE"
}

public enum AddPaymentType:String {
    case DEBIT = "DEBIT"
    case ACH_TRANSFER = "ACH_TRANSFER"
    case CASH = "CASH"
    case CHEQUE = "CHEQUE"
    case CREDIT = "CREDIT"
}

public class ModelPaymentInfo:ModelBase {
    
    public var addPaymentType:AddPaymentType        =   AddPaymentType.DEBIT
    @objc public dynamic var debitCardNo:Int        =   0
    @objc  public dynamic var paymentType:String     =  ""
    @objc public dynamic var achDate:String?        =   ""
    @objc public dynamic var paymentDate:Int        =   0
    @objc public dynamic var referenceNumber:String = ""
    @objc public dynamic var amount:Double          = 0.0
    @objc public dynamic var notes:String?          = ""
    @objc public dynamic var paymentNo:String?
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelPaymentInfo             = ModelPaymentInfo()
        modelPaymentInfo.id              = self.id
        modelPaymentInfo.addPaymentType  = self.addPaymentType
        modelPaymentInfo.debitCardNo     = self.debitCardNo
        modelPaymentInfo.achDate         = self.achDate
        modelPaymentInfo.paymentDate     = self.paymentDate
        modelPaymentInfo.referenceNumber = self.referenceNumber
        modelPaymentInfo.amount          = self.amount
        modelPaymentInfo.notes           = self.notes
        modelPaymentInfo.updated         = self.updated
        modelPaymentInfo.paymentType     = self.paymentType
        modelPaymentInfo.paymentNo = self.paymentNo
        return modelPaymentInfo
    }
}
