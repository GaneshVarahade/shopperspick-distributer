//
//  RequestInventry.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import RealmSwift

public class RequestInventry: BaseRequest {
      public   var transferNo:String?        = ""
      public   var fromShopId:String?        = ""
      public   var toShopId:String?          = ""
      public   var fromInventoryId:String?        = ""
      public   var toInventoryId:String?          = ""
      public   var fromShopName:String?      = ""
      public   var toShopName:String?        = ""
      public   var fromInventoryName:String? = ""
      public   var toInventoryName:String?   = ""
      public   var status:String?   = ""
      public   var completeTransfer:Bool                = false
      public var transferLogs   = [RequestCartProduct]()
}
