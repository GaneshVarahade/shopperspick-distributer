//
//  Models.swift
//  CodableRealm
//
//  Created by Apple on 01/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation


public class ResponseInvoices:BaseResponseModel {
   
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var shopId: String?
    public var customerId: String?
    public var invoiceNumber: String?
    public var dueDate:Int?
    public var company:String?
//    public var contact:String?
//    public var total:String?
//    public var balanceDue:String?
//    public var receiverCompany:String?
//    public var receiverType:String?
//    public var receiverContact:String?
//    public var receiverLiance:String?
//    public var receiverAddress:String?
//    public var remainingProducts:[ResponseProduct]?
//    public var items:[ResponseProduct]?
//    public var paymentInfo: [ResponsePaymentInfo]?
    public var employeeName:String?
 //   public var shippingManifests: [ResponseShipingMenifest]?
    
}

public class ResponseShipingMenifest: BaseResponseModel {
    
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var id: String?
    public var companyId: String?
    public var shopId: String?
    public var invoiceId: String?
    public var shippingManifestNo: String?
    public var invoiceAmount: Double?
    public var invoiceBalanceDue: Double?
    public var shippingNo:Int?
    public var deliveryDate:Int?
    public var driverName:String?
    public var driverLicenseNumber:String?
    public var driverMake:String?
    public var driverModel:String?
    public var driverColor:String?
    public var driverLicenPlate:String?
    public var asset:ResponseAsset?
    public var itemsToShip:[ResponseProduct]?
    
}

public class ResponseProduct:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var name:String?
    public var batchId:String?
    public var quantity:String?
}

public class ResponseAsset:BaseResponseModel{
    public var id: String?
    public var created: Int?
    public var modified: Int?
    public var deleted: Bool?
    public var updated: Bool?
    public var companyId: String?
    public var iconurl:String?
}

public class ResponseSignature:BaseResponseModel{
   public var id: String?
    
   public var created: Int?
    
   public var modified: Int?
    
   public var deleted: Bool?
    
   public var updated: Bool?
    
   public var companyId: String?
    
    
    public var name:String?
}

public class ResponsePaymentInfo:BaseResponseModel{
   public var id: String?
    
   public var created: Int?
    
   public var modified: Int?
    
   public var deleted: Bool?
    
   public var updated: Bool?
    
   public var companyId: String?
    
    
    public var debitNo:Int?
    public var ACHTransfer:String?
    public var paymentDate:Int?
    public var referenceNumber:Int?
    public var amount:Double?
    public var notest:String?
}

public class ResponseLocation:BaseResponseModel{
   public var id: String?
    
   public var created: Int?
    
   public var modified: Int?
    
   public var deleted: Bool?
    
   public var updated: Bool?
    
   public var companyId: String?
    
    
    public var shop:String?
    public var inventory:String?
}
public class ResponseProductTransfer:BaseResponseModel{
   public var id: String?
   public var created: Int?
   public var modified: Int?
   public var deleted: Bool?
   public var updated: Bool?
   public var companyId: String?
   public var name:String?
   public var transferAmount:String?
   public var expectedTotal:String?
}
public class ResponseTransfer:BaseResponseModel{
   public var id: String?
   public var created: Int?
   public var modified: Int?
   public var deleted: Bool?
   public var updated: Bool?
   public var companyId: String?
   public var name:String?
   public var request:String?
   public var date:Int?
   public var fromLocation:ResponseLocation?
   public var toLocation:ResponseLocation?
   public var products:[ResponseLocation] = []
    
}
public class ResponseProductReceived:BaseResponseModel{
   public var id: String?
   public var created: Int?
   public var modified: Int?
   public var deleted: Bool?
   public var updated: Bool?
   public var companyId: String?
   public var name:String?
   public var expected:String?
   public var received:String?
}

public   class ResponsePurchaseOrder:BaseResponseModel{
   public var id: String?
    
   public var created: Int?
    
   public var modified: Int?
    
   public var deleted: Bool?
    
   public var updated: Bool?
    
   public var companyId: String?
    
    
    public var purchaseOrderNumber:Int?
    public var isMetRc:String?
    public var metrcId:String?
    public var status:String?
    public var origin:String?
    public var received:String?
    public var productInShipment:[ResponseProduct] = []
    public var productReceived:[ResponseProductReceived]
}
