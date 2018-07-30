//
//  ModelShipingMenifest.swift
//  CodableRealm
//
//  Created by Apple on 03/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelShipingMenifest:ModelBase {
    
    @objc public dynamic var shippingManifestNo:String?  = ""
    @objc public dynamic var deliveryDate : Int          = 0
    @objc public dynamic var deliveryTime : Int          = 0
    @objc public dynamic var driverId:String?          = ""
    @objc public dynamic var driverName:String?          = ""
    @objc public dynamic var driverLicenseNumber:String?
    @objc public dynamic var vehicleMake:String?
    @objc public dynamic var vehicleModel:String?
    @objc public dynamic var vehicleColor:String?
    @objc public dynamic var vehicleLicensePlate:String? 
    @objc public dynamic var driverLicenPlate:String?
    @objc public dynamic var signaturePhoto:String?      = ""
    @objc public dynamic var receiverCompany:String?     = ""
    @objc public dynamic var receiverType:String?        = ""
    @objc public dynamic var receiverContact:String?     
    @objc public dynamic var receiverLicense:String?  
    @objc public dynamic var invoiceStatus:String?
    @objc public dynamic var signatureAsset:ModelSignatureAsset?
    
    var receiverAddress:ModelAddres?
    var selectedItems = List<ModelRemainingProduct>()
    
    open override class func primaryKey() -> String? {
        return "id"
    }
   
    public override func copy(with zone: NSZone?) -> Any { 

        let modelShipingMenifest                 = ModelShipingMenifest()
        modelShipingMenifest.id                  = self.id
        modelShipingMenifest.companyId           = self.companyId
        modelShipingMenifest.shippingManifestNo  = self.shippingManifestNo
        modelShipingMenifest.deliveryDate        = self.deliveryDate
        modelShipingMenifest.deliveryTime        = self.deliveryTime
        modelShipingMenifest.driverId            = self.driverId
        modelShipingMenifest.driverName          = self.driverName
        modelShipingMenifest.driverLicenseNumber = self.driverLicenseNumber
        modelShipingMenifest.vehicleMake         = self.vehicleMake
        modelShipingMenifest.vehicleModel        = self.vehicleModel
        modelShipingMenifest.vehicleColor        = self.vehicleColor
        modelShipingMenifest.signaturePhoto      = self.signaturePhoto
        modelShipingMenifest.driverLicenPlate    = self.driverLicenPlate
        modelShipingMenifest.vehicleLicensePlate = self.vehicleLicensePlate
        modelShipingMenifest.receiverCompany     = self.receiverCompany
        modelShipingMenifest.receiverType        = self.receiverType
        modelShipingMenifest.receiverContact     = self.receiverContact
        modelShipingMenifest.receiverLicense     = self.receiverLicense
        modelShipingMenifest.receiverAddress     = self.receiverAddress
        modelShipingMenifest.invoiceStatus       = self.invoiceStatus
        modelShipingMenifest.signatureAsset      = self.signatureAsset
        modelShipingMenifest.updated            = self.updated
        for item in self.selectedItems {
            
            modelShipingMenifest.selectedItems.append(item.copy() as! ModelRemainingProduct)
            
        }
        
        return modelShipingMenifest
    }
    
    public override var description: String {
        return "shippingManifestNo: \(shippingManifestNo), signatureAsset: \(signatureAsset)"
    }
}