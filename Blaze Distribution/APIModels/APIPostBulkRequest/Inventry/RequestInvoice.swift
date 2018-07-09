//
//  RequestInvoice.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import RealmSwift

public class RequestInvoice: BaseRequest {
      public   var invoiceNumber: String?  = ""
      public   var dueDate:String?         = ""
      public   var customerId:String?      = ""
      public   var vendorCompany:String?         = ""
      public   var salesPerson:String?         = ""
      public   var contact:String?         = ""
      public   var invoiceStatus:String?
      public   var total:Double           = 0.0
      public   var balanceDue:Double      = 0.0
    
      public   var vendorLicenseNumber:String?
      public   var vendorCompanyType:String?
      public   var vendorPhone:String?
      public   var vendorAddress:String?
      public   var vendorCity:String?
      public   var vendorState:String?
      public   var vendorZipcode:String?
      public   var vendorCountry:String?
    
      public var invoicePyamentInfo   = [RequestModelInvoicePaymentInfo]()
      public var shipingMainfest = [RequestModelShipingMainfest]()
}
