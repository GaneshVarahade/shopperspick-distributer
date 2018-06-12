//
//  ResponseShippingManifests.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public class ResponseShippingManifests:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    
    public var receiverCompany:ResponseReceiverCustomerCompany?
    public var receiverType:ResponseReceiverCustomerCompany?
    public var receiverContact:ResponseReceiverCustomerCompany?
    public var receiverLicense:ResponseReceiverCustomerCompany?
    public var receiverAddress:ResponseReceiverCustomerCompany?
    
    
    public var shippingManifestNo: String?
    public var deliveryDate:Int?
    public var driverName:String?
    public var driverLicenceNumber:String?
    public var vehicleMake:String?
    public var vehicleModel:String?
    public var vehicleLicensePlate:String?
    public var signaturePhoto:String?
}
