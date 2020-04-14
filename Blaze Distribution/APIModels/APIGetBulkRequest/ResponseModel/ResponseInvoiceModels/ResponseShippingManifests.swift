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
    public var deliveryTime: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    
    public var receiverCompany:ResponseReceiverCustomerCompany?
    public var receiverType:ResponseReceiverCustomerCompany?
    public var receiverContact:ResponseReceiverCustomerCompany?
    public var receiverLicense:ResponseReceiverCustomerCompany?
    public var receiverAddress:ResponseReceiverCustomerCompany?
    
    public var invoiceStatus:String?
    public var shippingManifestNo: String?
    public var deliveryDate:Int?
    public var driverName:String?
    public var driverLicenceNumber:String?
    public var businessLicense:String?
    public var transporterAgentID:String?
    public var vehicleMake:String?
    public var vehicleModel:String?
    public var vehicleLicensePlate:String?
    public var signaturePhoto:ResposeSignaturePhoto?
    public var shipperInformation:ResponseShipperInfo?
    public var productMetrcInfo:[ResponseProductMetricInfo]?
}


public class ResponseShipperInfo : BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    public var customerCompanyId: String?
    public var companyContactId: String?

}
public class ResponseProductMetricInfo : BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var productId : String?
    
    public var orderItemId : String?
    
    public var quantity : Double?
    
    public var batchDetails : [ResponseBatchDetails]?
}

public class ResponseBatchDetails : BaseResponseModel{
    public var id: String?
    
    public var created: Int?
    
    public var modified: Int?
    
    public var deleted: Bool?
    
    public var updated: Bool?
    
    public var companyId: String?
    
    public var batchId :  String?
    
    public var batchSku : String?
    
    public var metrcLabel : String?
    
    public var quantity : Double?
    
    public var prepackageItemId : String?
    public var overrideInventoryId : String?
    
}
