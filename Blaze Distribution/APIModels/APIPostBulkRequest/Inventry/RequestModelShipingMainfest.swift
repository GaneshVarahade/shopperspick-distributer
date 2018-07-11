//
//  File.swift
//  Blaze Distribution
//
//  Created by Apple on 05/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm

public class RequestAsset: BaseRequest {
    
    public var name:String? = ""
    public var type:String?  = ""
    public var publicURL:String?  = ""
    public var active:Bool = false
    public var secured:Bool = false
    public var thumbURL:String? = ""
    public var mediumURL:String? = ""
    public var largeURL:String? = ""
    public var assetType:String? = ""
    
}
public class RequestModelShipingMainfest: BaseRequest {
      public   var shippingManifestNo:String?  = ""
      public   var deliveryDate : Int          = 0
      public   var deliveryTime : Int          = 0
      public   var driverId:String? = ""
      public   var driverName:String?          = ""
      public   var driverLicenseNumber:String?
      public   var vehicleMake:String?
      public   var vehicleModel:String?
      public   var vehicleColor:String?
      public   var vehicleLicensePlate:String?
      public   var driverLicenPlate:String?
      public   var signaturePhoto:RequestAsset?
      public   var receiverCompany:String?     = ""
      public   var receiverType:String?        = ""
      public   var receiverContact:String?
      public   var receiverLicense:String?
      public   var invoiceStatus:String?
    
      public var shipperInformation :RequestShipperInformation?
      public var receiverInformation : RequestReceiverInformation?
      public   var productMetrcInfo = [RequestShippingMainfestSelectedItem]()
}

