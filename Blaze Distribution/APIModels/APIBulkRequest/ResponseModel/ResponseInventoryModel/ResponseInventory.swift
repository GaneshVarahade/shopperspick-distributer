//
//  ResponseInventory.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 13/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public enum TransferStatus:String {
    case PENDING = "PENDING"
}

public class ResponseInventory:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?

    public var transferNo: String?
    public var fromShopId: String?
    public var toShopId: String?
    public var fromShopName:String?
    public var toShopName:String?
    public var fromInventoryName:String?
    public var toInventoryName:String?

    public var shopId:String?
    public var name:String?
    
}
