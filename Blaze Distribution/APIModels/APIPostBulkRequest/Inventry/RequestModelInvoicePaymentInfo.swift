//
//  RequestModelInvoiceItems.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class pyamentNotes: BaseRequest{
    public var message:String? = ""
}

public class RequestModelInvoicePaymentInfo: BaseRequest {
      public   var debitCardNo:Int        =   0
      public   var achDate:Int         =   0
      public   var paidDate:Int        =   0
      public   var referenceNo:String = ""
      public   var amountPaid:Double          = 0.0
      public   var notes:pyamentNotes?         
      public   var paymentType:String          = ""
}
