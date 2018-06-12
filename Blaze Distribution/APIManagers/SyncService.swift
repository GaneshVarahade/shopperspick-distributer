//
//  SyncService.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public final class SyncService {
    
    private var queue : DispatchQueue = DispatchQueue(label: "com.blaze.distribution.Blaze-Distribution")
    private static var syncService: SyncService!
    
    private init(){}
    public static func sharedInstance() -> SyncService {
        
        if syncService == nil {
            syncService = SyncService()
        }
        
        return syncService
    }
    
    private var isUpdating:Bool = false
    
    
    public func syncData() {
        
        ///Synchronized block for multithreaded environment
        queue.sync {
            
            /// If Data is already syncing, then return from here
            guard !isUpdating else{
                return
            }
            
            /// If network is not available then return
            guard ReachabilityManager.shared.networkStatus() else {
                return
            }
            isUpdating = true
        }
        
        if isSignatureAvailable() {
            
            syncSignature()
            
        }else if isPostBulkAvailable() {
            
            syncPostBulkData()
            
        }else{
            syncGetBulkData()
        }
        
    }
    
    private func isSignatureAvailable() -> Bool {
        
        return false
    }
    
    private func isPostBulkAvailable() -> Bool {
        
        return false
    }
    
    private func syncSignature() {
        
        ///After API complete call resync
    }
 
    private func syncPostBulkData(){
        
        ///After API complete call resync
    }
    
    private func syncGetBulkData() {
        
        WebServicesAPI.sharedInstance().BulkAPI(request: RequestBulkAPI()) { (result:ResponseBulkRequest?,error:PlatformError?) in
            if error != nil{
                print(error?.message! ?? "Error")
                return
            }
            
            print(result?.invoice?.values?.count)
            print(result?.purchaseOrder?.values?[0].poNumber)
            print(result?.purchaseOrder?.values?[0].poProductRequestList?[0].productName)
            
            if let arrayPurchaseOrders = result?.purchaseOrder?.values {
                    self.savePurchaseOrder(arrayPurchaseOrders)
            }
        }
    }
    
     private func resync() {
        isUpdating = false
        syncData()
        
    }
    
    private func savePurchaseOrder(_ arrayPurchase: [ResponsePurchaseOrder]){
        
        for respPurchaseOrder in arrayPurchase {
            
            let modelPurcahseOrder:ModelPurchaseOrder = ModelPurchaseOrder()
            
            modelPurcahseOrder.purchaseOrderNumber = respPurchaseOrder.poNumber
            modelPurcahseOrder.isMetRc = respPurchaseOrder.metrc ?? false
            modelPurcahseOrder.received = respPurchaseOrder.receivedDate ?? 0
            modelPurcahseOrder.status = respPurchaseOrder.purchaseOrderStatus
            
            if let listProdReq = respPurchaseOrder.poProductRequestList {
                
                for productReq in listProdReq {
                    let modelPOProduct = ModelPurchaseOrderProduct()
                    modelPOProduct.id   = productReq.id
                    modelPOProduct.name = productReq.productName
                    modelPOProduct.quantity = productReq.requestQuantity ?? 0
                    modelPOProduct.batchId = productReq.batchId
                    
                    modelPurcahseOrder.productInShipment.append(modelPOProduct)
                }
            }
            
            //Write to database
            RealmManager().write(table: modelPurcahseOrder)
        }
    }
}
