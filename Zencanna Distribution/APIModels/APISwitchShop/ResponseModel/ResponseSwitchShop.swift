//
//  ResponseSwitchShop.swift
//  shopperspick Distribution
//
//  Created by Apple on 24/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class ResponseSwitchShop:BaseResponseModel {
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var assignedShop: ResponseAssignedShop?
}
