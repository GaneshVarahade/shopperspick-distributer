//
//  ResponseTransferUpdate.swift
//  BLAZE Distribution
//
//  Created by Nishant's Mac on 20/11/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public protocol BaseResponseModel1:Decodable{
    var id:String?{get set}
    var created: Int?{get set}
    var modified: Int?{get set}
    var deleted: Bool?{get set}
    var updated: Bool?{get set}
    var companyId:String?{get set}
    var shopId: String?{get set}
    var status: String?{get set}
    var createByEmployeeId: String?{get set}
    var acceptByEmployeeId: String?{get set}
    var declineByEmployeeId: String?{get set}
    var createdByEmployeeName: String?{get set}
    var acceptByEmployeeName: String?{get set}
    var declineByEmployeeName: String?{get set}
}


public class ResponseUpdateTransferStatus: BaseResponseModel1  {
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopId: String?
    public var status: String?
    public var createByEmployeeId: String?
    public var acceptByEmployeeId: String?
    public var declineByEmployeeId: String?
    public var createdByEmployeeName: String?
    public var acceptByEmployeeName: String?
    public var declineByEmployeeName: String?
}
