//
//  ResponseVendor.swift
//  shopperspick Distribution
//
//  Created by Fidel iOS on 08/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponseVendorAddress: BaseResponseModel {
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var address: String?
    public var city: String?
    public var state: String?
    public var zipCode: String?
    public var country: String?
    
}
public class ResponseVendor:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var name:String?
    public var licenseNumber:String?
    public var companyType:String?
    public var phone:String?
    public var address: ResponseVendorAddress?
}
