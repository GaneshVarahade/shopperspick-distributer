//
//  newRequestResponse.swift
//  shopperspick Distribution
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
    public var quantity: Double = 0.0
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


public class RequestGetAllVendor : BaseRequest{
   
}
public class ResponseGetAllVendor : BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var values : [AllVendor]?

}

public class AllVendor : BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    
    public var companyType : String?
    public var name :  String?
    public var licenseNumber : String?
    public var address : companyAddress?
    public var phone : String?
    
}

public class companyAddress : BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var address: String?
    
}


//For company contact
public class RequestGetCompanyContact : BaseRequest{
    public var customerCompanyId : String?
}

public class ResponseGetCompanyContact : BaseResponseModel {
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var values : [AllCompanyContact]?

}

public class AllCompanyContact : BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    
    public var phoneNumber : String?
    public var firstName : String?
    public var lastName : String?

}

class ResponseProductByBatchSku : BaseResponseModel{
    var id: String?
    
    var created: Int?
    
    var modified: Int?
    
    var deleted: Bool?
    
    var updated: Bool?
    
    var companyId: String?
}

class RequestProductByBatchSku : BaseRequest{
    var batchSku : String?
}

class RequestProductByShopId : BaseRequest{
    var shopId: String?
    var status: String?
    var currentTimeStamp:Double?
}

class ResponseProductByShopId : BaseResponseModel{
    var id: String?
    
    var created: Int?
    
    var modified: Int?
    
    var deleted: Bool?
    
    var updated: Bool?
    
    var companyId: String?
    
    var values:[ResponseProduct]?
}

class RequestGetAll : BaseRequest{
    var module: String?
    var filter: String?
}
