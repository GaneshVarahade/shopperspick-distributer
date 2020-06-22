
//
//  File.swift
//  shopperspick Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class RequestShippingMainfestSelectedItem: BaseRequest {
      public var productId:String? = ""
      public var orderItemId:String? = ""
      //public   var productName:String? = ""
     // public   var remainingQuantity:Double = 0.0
      public var quantity:Double = 0.0
      public var batchDetails = [RequestBatchDetails]()
     // public   var isSelected:Bool = false
}

public class RequestBatchDetails : BaseRequest{

    public var batchId :  String?
    public var batchSku : String?
    public var metrcLabel : String?
    public var quantity : Double?
    public var prepackageItemId : String?
    public var overrideInventoryId : String?
    
}
