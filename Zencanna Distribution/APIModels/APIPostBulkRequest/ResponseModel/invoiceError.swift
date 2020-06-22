//
//  File.swift
//  shopperspick Distribution
//
//  Created by Apple on 12/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class invoiceErrorRequest :BaseResponseModel{
    public var id:String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId:String?
}

public class invoiceError :BaseResponseModel{
    public var id:String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId:String?
    public var error:String?
     public var request:invoiceErrorRequest?
}
