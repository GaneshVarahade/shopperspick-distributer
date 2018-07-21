//
//  ResponseLogin.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ResponseLogin:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var accessToken: String?
    public var assetAccessToken: String?
    public var appType: String?
    
    public var appTarget: String?
    public var sessionId: String?
    public var shops:[ResponseShop]?
    public var employee: ResponseEmployee?
    public var assignedShop: ResponseAssignedShop?
    public var assignedTerminal: ResponseAssignedTerminal?
    
}

public class ResponseEmployee:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var firstName: String?
    public var lastName: String?
    public var pin: String?
    public var roleId: String?
}

public class ResponseAssignedShop:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopType:String?
    public var name: String?
    public var phoneNumber: String?
    public var emailAdress: String?
    public var address: ResponseAddress?
}

public class ResponseAssignedTerminal:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopId: String?
    public var active: Bool?
    public var assignedInventoryId: String?
    public var currentEmployeeId: String?
    
}

public class ResponseShop:BaseResponseModel{
    public var id:String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var name:String?
    public var shopType:String?
}

public class ResponseAddress:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var address: String?
    public var city: String?
    public var state: String?
}
