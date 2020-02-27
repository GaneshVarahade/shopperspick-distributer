//
//  ModelDriverInfo.swift
//  Blaze Distribution
//
//  Created by Apple on 09/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelDriverInfo:ModelBase{
    
    @objc public dynamic var driverId:String? = "" 
    @objc public dynamic var driverName:String?  = ""
    @objc public dynamic var driverLastName:String?  = ""
    @objc public dynamic var driversLicense:String?
    @objc public dynamic var vehicleMake:String?
    @objc public dynamic var vehicleModel:String?
    @objc public dynamic var vehicleColor:String?
    @objc public dynamic var vehicleLicensePlate:String?
    @objc public dynamic var active:Bool = false
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelDriver          = ModelDriverInfo()
        modelDriver.id           = self.id
        modelDriver.driverId     = self.driverId
        modelDriver.driverName   = self.driverName
        modelDriver.driverLastName = self.driverLastName
        modelDriver.driversLicense = self.driversLicense
        modelDriver.vehicleMake     = self.vehicleMake
        modelDriver.vehicleModel  = self.vehicleModel
        modelDriver.vehicleColor = self.vehicleColor
        modelDriver.vehicleLicensePlate     = self.vehicleLicensePlate
        modelDriver.active = self.active
        return modelDriver
    }
}
