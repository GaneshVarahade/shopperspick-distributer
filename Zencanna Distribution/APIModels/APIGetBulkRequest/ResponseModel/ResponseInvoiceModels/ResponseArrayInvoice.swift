//
//  ResponseArrayInvoice.swift
//  shopperspick Distribution
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponseArrayInvoice:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var total:Int?
    public var beforeDate:Int?
    public var afterDate:Int?
    public var values:[ResponseInvoice]?
}
