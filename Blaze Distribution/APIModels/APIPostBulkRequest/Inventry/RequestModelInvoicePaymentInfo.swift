//
//  RequestModelInvoiceItems.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class RequestModelInvoicePaymentInfo: BaseRequest {
      public   var debitCardNo:Int        =   0
      public   var achDate:String         =   ""
      public   var paidDate:Int        =   0
      public   var referenceNo:String = ""
      public   var amount:Double          = 0.0
      public   var notes:String          = ""
}
