//
//  newRequestResponse.swift
//  BLAZE Distribution
//
//  Created by Mac on 07/10/19.
//  Copyright © 2019 Fidel iOS. All rights reserved.
//

import Foundation

import Foundation
import Realm
import RealmSwift

public class RequestGetAllInventory:BaseRequest{
    
}

public class ResponseGetAllInvetory:BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var values : [AllInvetory]?
    
}

public class AllInvetory : BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopId : String?
    public var type: String?
    public var name : String?
}

public class RequestGetallBatches : BaseRequest{
    public var productId : String?
}

public class batchQuantityMapResponse : BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?

}

public class getbatches : BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopId : String?
    
    public var sku : String?
    //public var batchNo : Double?
    public var batchQuantityMap : [String: Int]?
}
public class ResponseGetAllBatches : BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopId : String?
    public var values : [getbatches]?
}
