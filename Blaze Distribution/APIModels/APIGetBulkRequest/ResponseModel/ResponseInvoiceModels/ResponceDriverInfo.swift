
//
//  File.swift
//  Blaze Distribution
//
//  Created by Apple on 09/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ResponceDriverInfo :BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var driverId:String?
    public var firstName:String?
    public var driverLicenceNumber:String?
    public var vehicleMake:String?
    public var vehicleModel:String?
    public var vehicleColor:String?
    public var vehicleLicensePlate:String?
    public var signaturePhoto:String?
}
