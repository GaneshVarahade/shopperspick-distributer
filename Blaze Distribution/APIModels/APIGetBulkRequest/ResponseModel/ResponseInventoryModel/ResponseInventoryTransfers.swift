//
//  responseInventory.swift
//  Blaze Distribution
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponseInventoryTransfers: BaseResponseModel {
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var transferNo: String?
    public var fromShopId: String?
    public var toShopId: String?
    public var fromInventoryId: String?
    public var toInventoryId: String?
    public var fromShopName:String?
    public var toShopName:String?
    public var fromInventoryName:String?
    public var toInventoryName:String?
    public var createdByEmployeeName:String?
    public var status:String?
    public var completeTransfer:Bool?
    public var oldId:String?
}
