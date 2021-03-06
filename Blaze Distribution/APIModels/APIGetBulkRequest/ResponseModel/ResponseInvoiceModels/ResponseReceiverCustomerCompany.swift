//
//  ResponseReceiverCustomerCompany.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 11/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ResposeSignaturePhoto:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    
    public var name:String?
    public var key:String?
    public var type:String?
    public var publicURL:String?
    public var active:Bool?
    public var secured:Bool?
    public var thumbURL:String?
    public var mediumURL:String?
    public var largeURL:String?
    public var assetType:String?
}

public class ResponseReceiverCustomerCompany:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var name:String?
    public var vendorType:String?
    public var phone:String?
    public var licenseNumber:String?
    public var address:ResponseAddress?
    
}
