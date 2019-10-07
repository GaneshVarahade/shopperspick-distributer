//
//  File.swift
//  Blaze Distribution
//
//  Created by Apple on 10/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class ModelSignatureAsset:ModelBase{
    @objc public dynamic var name:String? = ""
    @objc public dynamic var key:String? = ""
    @objc public dynamic var type:String?  = ""
    @objc public dynamic var publicURL:String?  = ""
    @objc public dynamic var active:Bool = false
    @objc public dynamic var secured:Bool = true
    @objc public dynamic var thumbURL:String? = ""
    @objc public dynamic var mediumURL:String? = ""
    @objc public dynamic var largeURL:String? = ""
    @objc public dynamic var assetType:String? = ""
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelSignature          = ModelSignatureAsset()
        modelSignature.id           = self.id
        modelSignature.name         = self.name
        modelSignature.type   = self.type
        modelSignature.publicURL = self.publicURL
        modelSignature.active = self.active
        modelSignature.secured     = self.secured
        modelSignature.thumbURL  = self.thumbURL
        modelSignature.mediumURL = self.mediumURL
        modelSignature.largeURL     = self.largeURL
        modelSignature.assetType     = self.assetType
        modelSignature.key = self.key
        return modelSignature
    }
    
    public override var description: String {
        return "name: \(name), largeURL: \(largeURL)"
    }
    
    open func getURL() -> String! {
        if self.secured {
            if let k : String = key {
                return DistributionConfig.sharedInstance().getAppUrl() + "/api/v1/pos/assets/\(k)"
            }
        }
        
        
        if let pURL = self.thumbURL {
            return pURL
        }
        if let pURL = self.publicURL {
            return pURL
        }
        if let k : String = key {
            return DistributionConfig.sharedInstance().getAppUrl() + "/api/v1/pos/assets/\(k)"
        }
        return nil
    }
    
    open func getNSURL() -> URL! {
        if let url : String = getURL() {
            return URL(string: url)
        }
        return nil
    }
}


public class ModelProductMetrcInfo:ModelBase{
    @objc public dynamic var productId:String? = ""
    @objc public dynamic var orderItemId:String? = ""
    @objc public dynamic var quantity:Double  =  0
     var batchDetailsList = List<ModelBatchDetails>()
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelMetricInfo          = ModelProductMetrcInfo()
        modelMetricInfo.id           = self.productId
        modelMetricInfo.productId    = self.productId
        modelMetricInfo.orderItemId  = self.orderItemId
        modelMetricInfo.quantity     = self.quantity
        for item in self.batchDetailsList {
            modelMetricInfo.batchDetailsList.append(item.copy() as! ModelBatchDetails)
        }
        return modelMetricInfo
}

}

public class ModelBatchDetails:ModelBase{
    @objc public dynamic var batchId:String? = ""
    @objc public dynamic var batchSku:String? = ""
    @objc public dynamic var metrcLabel:String? = ""
    @objc public dynamic var prepackageItemId:String? = ""
    @objc public dynamic var overrideInventoryId:String? = ""
    @objc public dynamic var quantity:Double  =  0
    
    open override class func primaryKey() -> String? {
        return "id"
    }
    public override func copy(with zone: NSZone? = nil) -> Any {
        let modelBatchDetails          = ModelBatchDetails()
        modelBatchDetails.id         = self.batchId
        modelBatchDetails.batchId    = self.batchId
        modelBatchDetails.batchSku    = self.batchSku
        modelBatchDetails.metrcLabel  = self.metrcLabel
        modelBatchDetails.prepackageItemId     = self.prepackageItemId
        modelBatchDetails.overrideInventoryId  = self.overrideInventoryId
        modelBatchDetails.quantity     = self.quantity
        return modelBatchDetails
    }
    
}
