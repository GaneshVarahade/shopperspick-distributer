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
            
            if let arrayInvoices = result?.invoice?.values {
                self.saveDataInvoice(jsonData: arrayInvoices)
            }
            
            if let arayTransfers = result?.inventoryTransfers?.values {
                self.saveDataInventory(jsonData: arayTransfers)
            }
            
            EventBus.sharedBus().publishMain(EventBusEventType.SYNCDATA)
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
    
    func saveDataInvoice(jsonData: [ResponseInvoice]?){
        
        if let values = jsonData{
            
            for valu in values{
                
                let model: ModelInvoice = ModelInvoice()
                model.id                = valu.id
                model.companyId         = valu.companyId
                model.invoiceNumber     = valu.invoiceNumber
                model.dueDate           = valu.dueDate?.description
                model.balanceDue        = valu.balanceDue!
                model.company           = valu.company?.name
                model.balanceDue        = valu.balanceDue!
                model.contact           = valu.companyContact
                model.total             = valu.total!
                
                if let remaingProducts = valu.remainingProductInformations{
                    for remProd  in remaingProducts{
                        let temp               = ModelRemainingProduct()
                        temp.productId         = remProd.productId
                        temp.productName       = remProd.productName
                        temp.requestQuantity   = remProd.requestQuantity!
                        temp.remainingQuantity = remProd.remainingQuantity!
                        model.remainingProducts.append(temp)
                    }
                }else{
                    
                    print("Remaing nil..")
                }
                ///Mapping Items
                if let items = valu.items{
                    for item in items{
                        let itemTemp = ModelInvoiceItems()
                        itemTemp.productId = item.productId
                        itemTemp.productName = item.productName
                        itemTemp.batchId    = item.batchId
                        itemTemp.quantity = item.quantity
                        model.items.append(itemTemp)
                        
                    }
                    
                }else{
                    print("Items nil")
                }
                //Mapping Payment Info
                if let  paymentRec = valu.paymentsReceived{
                    
                    for payment in paymentRec{
                        let paymentTemp             = ModelPaymentInfo()
                        paymentTemp.id              = payment.id
                        paymentTemp.paymentDate     = payment.paidDate!
                        paymentTemp.referenceNumber = payment.referenceNo ?? ""
                        paymentTemp.amount          = payment.amountPaid!
                        model.paymentInfo.append(paymentTemp)
                    }
                }else{
                    
                    print("Payment info nil")
                }
                ///Mapping Shipping Manifests
                if valu.shippingManifests != nil, valu.shippingManifests!.count > 0 {
                    
                    for ship in valu.shippingManifests! {
                        let shipMen                 = ModelShipingMenifest()
                        shipMen.id                  = ship.id
                        shipMen.companyId           = ship.companyId
                        shipMen.driverName          = ship.driverName
                        shipMen.driverLicenseNumber = ship.driverLicenceNumber
                        shipMen.vehicleMake         = ship.vehicleMake
                        shipMen.vehicleModel        = ship.vehicleModel
                        shipMen.vehicleLicensePlate = ship.vehicleLicensePlate
                        shipMen.signaturePhoto      = ship.signaturePhoto
                        shipMen.receiverCompany     = ship.receiverCompany?.name
                        shipMen.receiverType        = ship.receiverCompany?.vendorType
                        shipMen.receiverContact     = ship.receiverCompany?.phone
                        shipMen.receiverLicense     = ship.receiverCompany?.licenseNumber
                        if let add = ship.receiverAddress?.address{
                            shipMen.receiverAddress?.id      = add.id
                            shipMen.receiverAddress?.city    = add.city
                            shipMen.receiverAddress?.address = add.address
                            shipMen.receiverAddress?.state   = add.state
                        }
                        model.shippingManifests.append(shipMen)
                    }
                }else{
                    print("From json shipingMenifest: Nil")
                }
                RealmManager().write(table: model)
            }
        }
        print("---Invoice Data Save---")
        
    }
    func saveDataInventory(jsonData: [ResponseInventory]?){
        if let values = jsonData{
            
            for value in values{
                let tempInventory = ModelInventory()
                tempInventory.id = value.id
                tempInventory.transferNo = value.transferNo
                tempInventory.fromInventoryName = value.fromInventoryName
                tempInventory.fromShopName = value.fromShopName
                tempInventory.toInventoryName = value.toInventoryName
                tempInventory.toShopId = value.toShopId
                tempInventory.toShopName = value.toShopName
                tempInventory.toInventoryName = value.toInventoryName
                RealmManager().write(table: tempInventory)
            }
        }else{
            print("Inventory is nil....")
        }
        print("---Inventory Data Save---")
    }
}
