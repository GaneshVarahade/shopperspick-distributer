//
//  ResponseBulkRequestModel.swift
//  Blaze Distribution
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponseBulkRequest: BaseResponseModel  {
    
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    var invoice: ResponseArrayInvoice?
    
    var inventory: ResponseArrayInventory?
    
    var purchaseOrder: ResponseArrayPurchaseOrder?
}
