import Foundation
import RealmSwift
import SKActivityIndicatorView

public final class SyncService {
    
    private static var syncService: SyncService!
    
    private init(){}
    public static func sharedInstance() -> SyncService {
        
        if syncService == nil {
            syncService = SyncService()
        }
        
        return syncService
    }
    
    private var isUpdating:Bool = false
    
    //POST,GET Data related operations
    public func syncData() {
        /// If Data is already syncing, then return from here
        guard !self.isUpdating else{
            return
        }
        /// If network is not available then return
        guard ReachabilityManager.shared.networkStatus() else {
            return
        }
        self.isUpdating = true
//        if self.isSignatureAvailable() {
//            self.syncSignature()
//        }
        
//        else if self.isPostBulkAvailable() {
//            self.syncPostBulkData()
//        }
        
       // else {
            self.syncGetBulkData()
        //}
        
    }
    
    //Check whether signature is available to post
    private func isSignatureAvailable() -> Bool {
        return getModelSignature().count > 0
    }
    
    //Check whether Bulk ia avaialble to post
    private func isPostBulkAvailable() -> Bool {
        
        let realmManager = RealmManager()
        AQLog.debug(tag: AQLog.TAG_DATABASE_DATA, text: "\(realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true").count)")
        AQLog.debug(tag: AQLog.TAG_DATABASE_DATA, text: "\(realmManager.readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true").count)")
        AQLog.debug(tag: AQLog.TAG_DATABASE_DATA, text: "\(realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true").count)")
        
        //Commented Temporaray
        return (realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true && putBulkError = '' ").count > 0
            ||
            realmManager.readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true && putBulkError = ''").count > 0
            ||
            realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true && putBulkError = ''").count > 0)
    }
    
    private func getModelSignature() ->[ModelSignature] {
       return RealmManager().readPredicate(type: ModelSignature.self, predicate: "updated = true")
    }
    
   
    //Upload signature and write "Signature Asset response" in to mainfest in invoice
    func postInvoiceWithSignature(requestSignature:RequestSignature,sigId : String,completion : @escaping (_ error : PlatformError?) -> Void){
        //Get image one by one from ModelSignature
//        let arrayModelSignature = getModelSignature()
////        if arrayModelSignature.count <= 0 {
////            self.callPostAPI { (error:PlatformError?) in
////                completion(error)
////            }
////        }
//        let requestSignature = RequestSignature()
//        let modelSign = ModelSignature()
//        if(arrayModelSignature.count > 0){
//        let modelSign = arrayModelSignature[0]
//        requestSignature.name = modelSign.name
//        requestSignature.invoiceId = modelSign.invoiceId
//        requestSignature.shippingMainfestId = modelSign.shippingMainfestId
//        }
//
        WebServicesAPI.sharedInstance().uploadSignature(request: requestSignature) {
            (result:ResponseAsset?, _ error:PlatformError?) in
            
            if error != nil{
                completion(error)
            }
            
            if result == nil {
               completion(error)
                //return
            }
            
            let modelInvoice = RealmManager().read(type: ModelInvoice.self, primaryKey: requestSignature.invoiceId!)
            
            for modelShip in (modelInvoice?.shippingManifests)!{
                if modelShip.shippingManifestNo == requestSignature.shippingMainfestId! {
                    
                    let modelAsset = ModelSignatureAsset()
                    modelAsset.id = result?.id
                    modelAsset.publicURL = result?.publicURL
                    modelAsset.thumbURL = result?.thumbURL
                    modelAsset.mediumURL = result?.mediumURL
                    modelAsset.largeURL = result?.largeURL
                    modelAsset.type = result?.type
                    modelAsset.name = result?.name
                    modelAsset.assetType = result?.assetType
                    modelAsset.key = result?.key
                    
                    //Assign Asset to ShippingMenifest
                    modelShip.signatureAsset = modelAsset
                    modelInvoice?.updated = true
                    RealmManager().write(table: modelInvoice!)
                    
                    //print(RealmManager().read(type: ModelInvoice.self, primaryKey:requestSignature.invoiceId!))
                    RealmManager().deletePredicate(type: ModelSignature.self, predicate: "id = '\(sigId)'")
                    break
                }
            }
            completion(error)
            
//           //call post bulk api
//            self.postInvoiceWithSignature(completion: { (error:PlatformError?) in
//                completion(error)
            //})
            
//            DispatchQueue.main.async {
//                self.resync()
//            }
        }
        
    }
    
    private func syncSignature() {
//        //Get image one by one from ModelSignature
//        let arrayModelSignature = getModelSignature()
//        if arrayModelSignature.count <= 0 {
//            self.resync()
//        }
//
//        let modelSign = arrayModelSignature[0]
//        let requestSignature = RequestSignature()
//        requestSignature.name = modelSign.name
//        requestSignature.invoiceId = modelSign.invoiceId
//        requestSignature.shippingMainfestId = modelSign.shippingMainfestId
//
//        WebServicesAPI.sharedInstance().uploadSignature(request: requestSignature) {
//            (result:ResponseAsset?, _ error:PlatformError?) in
//
//            if error != nil{
//                self.finishSync()
//                return
//            }
//
//            if result == nil {
//                self.resync()
//                return
//            }
//
//            let modelInvoice = RealmManager().read(type: ModelInvoice.self, primaryKey: requestSignature.invoiceId!)
//
//            for modelShip in (modelInvoice?.shippingManifests)!{
//                if modelShip.shippingManifestNo == requestSignature.shippingMainfestId! {
//
//                    let modelAsset = ModelSignatureAsset()
//                    modelAsset.id = result?.id
//                    modelAsset.publicURL = result?.publicURL
//                    modelAsset.thumbURL = result?.thumbURL
//                    modelAsset.mediumURL = result?.mediumURL
//                    modelAsset.largeURL = result?.largeURL
//                    modelAsset.type = result?.type
//                    modelAsset.name = result?.name
//                    modelAsset.assetType = result?.assetType
//                    modelAsset.key = result?.key
//
//                    //Assign Asset to ShippingMenifest
//                    modelShip.signatureAsset = modelAsset
//                    modelInvoice?.updated = true
//                    RealmManager().write(table: modelInvoice!)
//
//                    //print(RealmManager().read(type: ModelInvoice.self, primaryKey:requestSignature.invoiceId!))
//                    RealmManager().deletePredicate(type: ModelSignature.self, predicate: "id = '\(modelSign.id!)'")
//                    break
//                }
//            }
//
//            DispatchQueue.main.async {
//                self.resync()
//            }
//        }
        

    }
 
    //Post Bulk data saved offline , Only updated = "true"
    func callPostAPI(completion:@escaping(_ error : PlatformError?)-> Void){
        ///After API complete call resync, so syncdata can run recursively
        let realmManager: RealmManager = RealmManager()
        let modelPurchaseOrders = realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true && putBulkError = ''")
        let modelInventryTransfer = realmManager.readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true && putBulkError = ''")
        let modelInvoice = realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true && putBulkError = ''")
        
        
        
        let requestModel = RequestPostModel()
        
        //For Model purchase order
        for model in modelPurchaseOrders {
            //print("modelPurchaseOrders")
            let requestPurchase: RequestPurchaseOrder = RequestPurchaseOrder()
            requestPurchase.id = model.id
            requestPurchase.purchaseOrderNumber = model.purchaseOrderNumber
            requestPurchase.isMetRc = model.isMetRc
            requestPurchase.metrcId = model.metrcId
            requestPurchase.purchaseOrderStatus = model.status
            requestPurchase.origin = model.origin
            requestPurchase.received = model.received
            requestPurchase.completedDate = model.completedDate
            
            for productReceived in model.productReceived {
                let requestPurchaseOrderReceived: RequestPurchaseOrderProductReceived = RequestPurchaseOrderProductReceived()
                requestPurchaseOrderReceived.id = productReceived.id
                requestPurchaseOrderReceived.productId = productReceived.productId
                requestPurchaseOrderReceived.productName = productReceived.name
                requestPurchaseOrderReceived.requestQuantity = productReceived.expected
                requestPurchaseOrderReceived.receivedQuantity = productReceived.received
                requestPurchaseOrderReceived.totalCost = productReceived.totalCost
                requestPurchaseOrderReceived.unitPrice = productReceived.unitPrice
                
                requestPurchaseOrderReceived.discount = productReceived.discount
                requestPurchaseOrderReceived.exciseTax = productReceived.exciseTax
                requestPurchaseOrderReceived.totalExciseTax = productReceived.totalExciseTax
                requestPurchaseOrderReceived.totalCultivationTax = productReceived.totalCultivationTax


                requestPurchase.poProductRequestList.append(requestPurchaseOrderReceived)
            }
            requestModel.purchaseOrder.append(requestPurchase)
        }
        
        //For Model Inventry Transfer
        for model in modelInventryTransfer {
            //print("modelInventryTransfer")
            let requestInventry: RequestInventry = RequestInventry()
            requestInventry.id = model.id
            requestInventry.oldId = model.id
            requestInventry.transferNo = model.transferNo
            requestInventry.fromShopId = model.fromShopId
            requestInventry.toShopId = model.toShopId
            requestInventry.fromShopName = model.fromShopName
            requestInventry.toShopName = model.toShopName
            requestInventry.fromInventoryName = model.fromInventoryName
            requestInventry.toInventoryName = model.toInventoryName
            requestInventry.status = model.status
            requestInventry.fromInventoryId = model.fromInventoryId
            requestInventry.toInventoryId = model.toInventoryId
            requestInventry.completeTransfer = model.completeTransfer
            requestInventry.createdByEmployeeName = model.createdByEmployeeName
            
            
            for productInCart in model.slectedProducts {
                let requestCartProduct: RequestCartProduct = RequestCartProduct()
                requestCartProduct.name = productInCart.name
                requestCartProduct.productId = productInCart.batchId
                requestCartProduct.transferAmount = productInCart.quantity
                requestInventry.transferLogs.append(requestCartProduct)
            }
            requestModel.inventoryTransfer.append(requestInventry)
        }
        
        
        // For Model Invoice
        for model in modelInvoice {
            
            //print("modelInvoice")
            let requestInvoice: RequestInvoice = RequestInvoice()
            requestInvoice.id = model.id
            requestInvoice.invoiceNumber = model.invoiceNumber
            //Convert Date string to int and send
            if let duedate = model.dueDate{
                requestInvoice.dueDate = DateFormatterUtil.formatStringToInt(dateTime: duedate, format: DateFormatterUtil.mmddyyyy)
            }
            //                requestInvoice.dueDate = DateFormatterUtil.formatStringToInt(dateTime: duedate, format: DateFormatterUtil.mmddyyyy)
            
            requestInvoice.vendorCompany = model.vendorCompany
            requestInvoice.customerId = model.customerId
            
            //Payment info list
            for payment in model.paymentInfo {
                if payment.updated == true{
                    let requestModelInvoicePayment: RequestModelInvoicePaymentInfo = RequestModelInvoicePaymentInfo()
                    requestModelInvoicePayment.debitCardNo = payment.debitCardNo
                    //Convert Date string to int and send
                    // print(payment.achDate!)
                    //                    if let achdate =  payment.achDate, achdate != ""{
                    //                         requestModelInvoicePayment.achDate = DateFormatterUtil.formatStringToInt(dateTime: achdate, format: DateFormatterUtil.mmddyyyy)
                    //                    }
                    requestModelInvoicePayment.paidDate = payment.paymentDate
                    requestModelInvoicePayment.referenceNo = payment.referenceNumber
                    requestModelInvoicePayment.amountPaid = payment.amount
                    requestModelInvoicePayment.paymentType = payment.paymentType
                    let notesModel: pyamentNotes = pyamentNotes()
                    notesModel.message = payment.notes
                    requestModelInvoicePayment.notes = notesModel
                    
                    requestInvoice.addPaymentRequest.append(requestModelInvoicePayment)
                }
            }
            
            //List shipping mainfest
            for shiping in model.shippingManifests {
                if shiping.updated == true{
                    
                    let requestModelShippingMainfest: RequestModelShipingMainfest = RequestModelShipingMainfest()
                    
                    requestModelShippingMainfest.shippingManifestNo = shiping.shippingManifestNo
                    requestModelShippingMainfest.deliveryDate = shiping.deliveryDate
                    requestModelShippingMainfest.deliveryTime = shiping.deliveryTime
                    requestModelShippingMainfest.driverId = shiping.driverId
                    requestModelShippingMainfest.driverName = shiping.driverName
                    requestModelShippingMainfest.vehicleMake = shiping.vehicleMake
                    requestModelShippingMainfest.vehicleModel = shiping.vehicleModel
                    requestModelShippingMainfest.vehicleColor = shiping.vehicleColor
                    requestModelShippingMainfest.vehicleLicensePlate = shiping.vehicleLicensePlate
                    requestModelShippingMainfest.driverLicenPlate = shiping.driverLicenPlate
                    
                    let requestAsset = RequestAsset()
                    requestAsset.name = shiping.signatureAsset?.name
                    
                    requestAsset.type = shiping.signatureAsset?.type
                    requestAsset.publicURL = shiping.signatureAsset?.publicURL
                    requestAsset.active = shiping.signatureAsset?.active ?? false
                    requestAsset.secured = shiping.signatureAsset?.secured ?? false
                    requestAsset.thumbURL = shiping.signatureAsset?.thumbURL
                    requestAsset.mediumURL = shiping.signatureAsset?.mediumURL
                    requestAsset.largeURL = shiping.signatureAsset?.largeURL
                    requestAsset.assetType = shiping.signatureAsset?.assetType
                    requestAsset.key = shiping.signatureAsset?.key
                    requestModelShippingMainfest.signaturePhoto = requestAsset
                    
                    requestModelShippingMainfest.receiverCompany = shiping.receiverCompany
                    requestModelShippingMainfest.receiverType = shiping.receiverType
                    requestModelShippingMainfest.receiverContact = shiping.receiverContact
                    requestModelShippingMainfest.receiverLicense = shiping.receiverLicense
                    requestModelShippingMainfest.invoiceStatus = shiping.invoiceStatus
                    
                    //separate Shipping and reciving data
                    let requestSipperInfo : RequestShipperInformation = RequestShipperInformation()
                    requestSipperInfo.companyId = shiping.shippercompanyId
                    requestSipperInfo.customerCompanyId = shiping.shippercustomerCompanyId
                    requestSipperInfo.companyContactId = shiping.shippercompanyContactId
                    
                    requestModelShippingMainfest.shipperInformation = requestSipperInfo
                    
                    let requestReciverInfo : RequestReceiverInformation = RequestReceiverInformation()
                    requestReciverInfo.customerCompanyId = model.customerId
                    requestModelShippingMainfest.receiverInformation = requestReciverInfo
                    
                    //add shiping selected items
//                    //Payment info list
//                    for selectedItem in shiping.selectedItems {
//                        let requestSelectedItemsShipping: RequestShippingMainfestSelectedItem = RequestShippingMainfestSelectedItem()
//                        requestSelectedItemsShipping.productId = selectedItem.productId
//
//                        var orderItemId = ""
//                        if (model.items.count > 0){
//                            for items in model.items{
//                                if let itemId = selectedItem.productId{
//                                    if items.productId == itemId{
//                                        orderItemId = items.orderItemId ?? ""
//                                    }
//                                }
//                            }
//                        }
//
//                        requestSelectedItemsShipping.orderItemId = orderItemId
//                        requestSelectedItemsShipping.quantity = selectedItem.requestQuantity
                    
                    for selecteProdMetric in shiping.productMetrcInfoList{
                        let objrequestprodinfo = RequestShippingMainfestSelectedItem()
                            objrequestprodinfo.productId = selecteProdMetric.productId
                        
                            var orderItemId = ""
                            if (model.items.count > 0){
                                for items in model.items{
                                    if let itemId = selecteProdMetric.productId{
                                        if items.productId == itemId{
                                           orderItemId = items.orderItemId ?? ""
                                                            }
                                                        }
                                                    }
                                                }
                        
                            objrequestprodinfo.orderItemId = orderItemId
                            objrequestprodinfo.quantity = selecteProdMetric.quantity
                        
                        for item in selecteProdMetric.batchDetailsList{
                             let objbatch = RequestBatchDetails()
                                 objbatch.batchId = item.batchId
                                 objbatch.batchSku = item.batchSku
                                 objbatch.metrcLabel = item.metrcLabel
                                 objbatch.quantity = item.quantity
                                 objbatch.prepackageItemId = item.prepackageItemId
                                 objbatch.overrideInventoryId = item.overrideInventoryId
                                 objrequestprodinfo.batchDetails.append(objbatch)
                         }
                    
                        requestModelShippingMainfest.productMetrcInfo.append(objrequestprodinfo)
                    }
                    
                    requestInvoice.addShippingManifestRequest.append(requestModelShippingMainfest)
                    
                }
                
            }
            
            requestModel.invoice.append(requestInvoice)
        }
        
        WebServicesAPI.sharedInstance().BulkPostAPI(request: requestModel) {
            (result:ResponseBulkRequest?,error:PlatformError?) in
            //DispatchQueue.global(qos: .userInitiated).async {
            
                // for inventoryTransferError object
                if let arrayInventory = result?.inventoryTransferError, arrayInventory.count > 0 {
                    for obj in arrayInventory {
                    
                        //print(obj.request?.id ?? "",obj.error ?? "")
                        let modelInvetry = RealmManager().read(type: ModelInventoryTransfers.self, primaryKey: (obj.request?.id)!)
                        modelInvetry?.putBulkError = obj.error ?? ""
                        modelInvetry?.updated = false
                        RealmManager().write(table: modelInvetry!)
                        // print(RealmManager().read(type: ModelInventoryTransfers.self, primaryKey: (obj.request?.id)!))
                    }
                    
                    let objerror = PlatformError()
                    objerror.message = arrayInventory[0].error
                    completion(error)
                    
                }else{
                    let modelInventryTransfer2 = realmManager.readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true && putBulkError = ''")
                    for model in modelInventryTransfer2 {
                        model.updated = false
                    }
                    realmManager.write(modelInventryTransfer2)
                }
                
                // for invoice object
                if let arrayInvoice = result?.invoiceError, arrayInvoice.count > 0{
                    
                    for obj in arrayInvoice {
                        //print(obj.request?.id ?? "",obj.error ?? "")
                        let modelInvoice = RealmManager().read(type: ModelInvoice.self, primaryKey: (obj.request?.id)!)
                        modelInvoice?.putBulkError = obj.error ?? ""
                        modelInvoice?.updated = false
                        
                        //Write Payment
                        let modelPaymentInfo = modelInvoice?.paymentInfo
                        for objInfo in modelPaymentInfo!{
                            objInfo.updated = false
                        }
                        
                        //Write Shipment
                        let modelShipment = modelInvoice?.shippingManifests
                        for objInfo in modelShipment!{
                            objInfo.updated = false
                        }
                        
                        RealmManager().write(table: modelInvoice!)
                        //print(RealmManager().read(type: ModelInvoice.self, primaryKey: (obj.request?.id)!))
                    }
                    let objerror = PlatformError()
                    objerror.message = arrayInvoice[0].error
                    completion(error)
                    
                }else{
                    let modelInvoice2 = realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true && putBulkError = ''")
                    for model in modelInvoice2 {
                        model.updated = false
                        
                        //Write Payment
                        let modelPaymentInfo = model.paymentInfo
                        for objInfo in modelPaymentInfo{
                            objInfo.updated = false
                        }
                        
                        //Write Shipment
                        let modelShipment = model.shippingManifests
                        for objInfo in modelShipment{
                            objInfo.updated = false
                        }
                    }
                    
                    realmManager.write(modelInvoice2)
                }
                
                
                // for purchaseOrder object
                if let arrayPo = result?.poError, arrayPo.count > 0{
                    
                    for obj in arrayPo {
                        //print(obj.request?.id ?? "" ,obj.error ?? "")
                        let modelPo = RealmManager().read(type: ModelPurchaseOrder.self, primaryKey: (obj.request?.id)!)
                        modelPo?.putBulkError = obj.error ?? ""
                        modelPo?.updated = false
                        RealmManager().write(table: modelPo!)
                        // print( RealmManager().read(type: ModelPurchaseOrder.self, primaryKey: (obj.request?.id)!))
                    }
                    
                    let objerror = PlatformError()
                    objerror.message = arrayPo[0].error
                    completion(error)
                    
                }else{
                    let modelPurchaseOrders2 = realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true && putBulkError = ''")
                    for model in modelPurchaseOrders2 {
                        model.updated = false
                    }
                    realmManager.write(modelPurchaseOrders2)
                }
                
//                DispatchQueue.main.async {
//                    self.resync()
//                    return
//                }
           // }
            completion(error)
        }

    }
    
    private func syncPostBulkData(){
//
//            ///After API complete call resync, so syncdata can run recursively
//            let realmManager: RealmManager = RealmManager()
//            let modelPurchaseOrders = realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true && putBulkError = ''")
//            let modelInventryTransfer = realmManager.readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true && putBulkError = ''")
//            let modelInvoice = realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true && putBulkError = ''")
//
//
//
//            let requestModel = RequestPostModel()
//
//            //For Model purchase order
//            for model in modelPurchaseOrders {
//                //print("modelPurchaseOrders")
//                let requestPurchase: RequestPurchaseOrder = RequestPurchaseOrder()
//                requestPurchase.id = model.id
//                requestPurchase.purchaseOrderNumber = model.purchaseOrderNumber
//                requestPurchase.isMetRc = model.isMetRc
//                requestPurchase.metrcId = model.metrcId
//                requestPurchase.purchaseOrderStatus = model.status
//                requestPurchase.origin = model.origin
//                requestPurchase.received = model.received
//                requestPurchase.completedDate = model.completedDate
//
//                for productReceived in model.productReceived {
//                    let requestPurchaseOrderReceived: RequestPurchaseOrderProductReceived = RequestPurchaseOrderProductReceived()
//                    requestPurchaseOrderReceived.id = productReceived.id
//                    requestPurchaseOrderReceived.productId = productReceived.productId
//                    requestPurchaseOrderReceived.name = productReceived.name
//                    requestPurchaseOrderReceived.requestQuantity = productReceived.expected
//                    requestPurchaseOrderReceived.receivedQuantity = productReceived.received
//                    requestPurchase.poProductRequestList.append(requestPurchaseOrderReceived)
//                }
//                requestModel.purchaseOrder.append(requestPurchase)
//            }
//
//            //For Model Inventry Transfer
//            for model in modelInventryTransfer {
//                //print("modelInventryTransfer")
//                let requestInventry: RequestInventry = RequestInventry()
//                requestInventry.id = model.id
//                requestInventry.oldId = model.id
//                requestInventry.transferNo = model.transferNo
//                requestInventry.fromShopId = model.fromShopId
//                requestInventry.toShopId = model.toShopId
//                requestInventry.fromShopName = model.fromShopName
//                requestInventry.toShopName = model.toShopName
//                requestInventry.fromInventoryName = model.fromInventoryName
//                requestInventry.toInventoryName = model.toInventoryName
//                requestInventry.status = model.status
//                requestInventry.fromInventoryId = model.fromInventoryId
//                requestInventry.toInventoryId = model.toInventoryId
//                requestInventry.completeTransfer = model.completeTransfer
//                requestInventry.createdByEmployeeName = model.createdByEmployeeName
//
//
//                for productInCart in model.slectedProducts {
//                    let requestCartProduct: RequestCartProduct = RequestCartProduct()
//                    requestCartProduct.name = productInCart.name
//                    requestCartProduct.productId = productInCart.batchId
//                    requestCartProduct.transferAmount = productInCart.quantity
//                    requestInventry.transferLogs.append(requestCartProduct)
//                }
//                requestModel.inventoryTransfer.append(requestInventry)
//            }
//
//
//            // For Model Invoice
//            for model in modelInvoice {
//
//                //print("modelInvoice")
//                let requestInvoice: RequestInvoice = RequestInvoice()
//                requestInvoice.id = model.id
//                requestInvoice.invoiceNumber = model.invoiceNumber
//                //Convert Date string to int and send
//                if let duedate = model.dueDate{
//                    requestInvoice.dueDate = DateFormatterUtil.formatStringToInt(dateTime: duedate, format: DateFormatterUtil.mmddyyyy)
//                }
////                requestInvoice.dueDate = DateFormatterUtil.formatStringToInt(dateTime: duedate, format: DateFormatterUtil.mmddyyyy)
//
//                requestInvoice.vendorCompany = model.vendorCompany
//                requestInvoice.customerId = model.customerId
//
//                //Payment info list
//                for payment in model.paymentInfo {
//                    if payment.updated == true{
//                        let requestModelInvoicePayment: RequestModelInvoicePaymentInfo = RequestModelInvoicePaymentInfo()
//                        requestModelInvoicePayment.debitCardNo = payment.debitCardNo
//                        //Convert Date string to int and send
//                        // print(payment.achDate!)
//                        //                    if let achdate =  payment.achDate, achdate != ""{
//                        //                         requestModelInvoicePayment.achDate = DateFormatterUtil.formatStringToInt(dateTime: achdate, format: DateFormatterUtil.mmddyyyy)
//                        //                    }
//                        requestModelInvoicePayment.paidDate = payment.paymentDate
//                        requestModelInvoicePayment.referenceNo = payment.referenceNumber
//                        requestModelInvoicePayment.amountPaid = payment.amount
//                        requestModelInvoicePayment.paymentType = payment.addPaymentType.rawValue
//                        let notesModel: pyamentNotes = pyamentNotes()
//                        notesModel.message = payment.notes
//                        requestModelInvoicePayment.notes = notesModel
//
//                        requestInvoice.addPaymentRequest.append(requestModelInvoicePayment)
//                    }
//                }
//
//                //List shipping mainfest
//                for shiping in model.shippingManifests {
//                    if shiping.updated == true{
//
//                        let requestModelShippingMainfest: RequestModelShipingMainfest = RequestModelShipingMainfest()
//
//                        requestModelShippingMainfest.shippingManifestNo = shiping.shippingManifestNo
//                        requestModelShippingMainfest.deliveryDate = shiping.deliveryDate
//                        requestModelShippingMainfest.deliveryTime = shiping.deliveryTime
//                        requestModelShippingMainfest.driverId = shiping.driverId
//                        requestModelShippingMainfest.driverName = shiping.driverName
//                        requestModelShippingMainfest.vehicleMake = shiping.vehicleMake
//                        requestModelShippingMainfest.vehicleModel = shiping.vehicleModel
//                        requestModelShippingMainfest.vehicleColor = shiping.vehicleColor
//                        requestModelShippingMainfest.vehicleLicensePlate = shiping.vehicleLicensePlate
//                        requestModelShippingMainfest.driverLicenPlate = shiping.driverLicenPlate
//
//                        let requestAsset = RequestAsset()
//                        requestAsset.name = shiping.signatureAsset?.name
//
//                        requestAsset.type = shiping.signatureAsset?.type
//                        requestAsset.publicURL = shiping.signatureAsset?.publicURL
//                        requestAsset.active = shiping.signatureAsset?.active ?? false
//                        requestAsset.secured = shiping.signatureAsset?.secured ?? false
//                        requestAsset.thumbURL = shiping.signatureAsset?.thumbURL
//                        requestAsset.mediumURL = shiping.signatureAsset?.mediumURL
//                        requestAsset.largeURL = shiping.signatureAsset?.largeURL
//                        requestAsset.assetType = shiping.signatureAsset?.assetType
//                        requestAsset.key = shiping.signatureAsset?.key
//                        requestModelShippingMainfest.signaturePhoto = requestAsset
//
//                        requestModelShippingMainfest.receiverCompany = shiping.receiverCompany
//                        requestModelShippingMainfest.receiverType = shiping.receiverType
//                        requestModelShippingMainfest.receiverContact = shiping.receiverContact
//                        requestModelShippingMainfest.receiverLicense = shiping.receiverLicense
//                        requestModelShippingMainfest.invoiceStatus = shiping.invoiceStatus
//
//                        //separate Shipping and reciving data
//                        let requestSipperInfo : RequestShipperInformation = RequestShipperInformation()
//                        requestSipperInfo.companyId = model.companyId
//                        requestModelShippingMainfest.shipperInformation = requestSipperInfo
//
//                        let requestReciverInfo : RequestReceiverInformation = RequestReceiverInformation()
//                        requestReciverInfo.customerCompanyId = model.customerId
//                        requestModelShippingMainfest.receiverInformation = requestReciverInfo
//
//                        //add shiping selected items
//                        //Payment info list
//                        for selectedItem in shiping.selectedItems {
//                            let requestSelectedItemsShipping: RequestShippingMainfestSelectedItem = RequestShippingMainfestSelectedItem()
//                            requestSelectedItemsShipping.productId = selectedItem.productId
//
//                            var orderItemId = ""
//                            if (model.items.count > 0){
//                                for items in model.items{
//                                    if let itemId = selectedItem.productId{
//                                        if items.productId == itemId{
//                                            orderItemId = items.orderItemId ?? ""
//                                        }
//                                    }
//                                }
//                            }
//
//                            requestSelectedItemsShipping.orderItemId = orderItemId
//                            //requestSelectedItemsShipping.productName = selectedItem.productName
//                            //requestSelectedItemsShipping.remainingQuantity = selectedItem.remainingQuantity
//                            requestSelectedItemsShipping.quantity = selectedItem.requestQuantity
//                            //requestSelectedItemsShipping.isSelected = selectedItem.isSelected
//                            requestModelShippingMainfest.productMetrcInfo.append(requestSelectedItemsShipping)
//                        }
//
//                        requestInvoice.addShippingManifestRequest.append(requestModelShippingMainfest)
//
//                    }
//
//                }
//
//                requestModel.invoice.append(requestInvoice)
//            }
//
//            WebServicesAPI.sharedInstance().BulkPostAPI(request: requestModel) {
//                (result:ResponseBulkRequest?,error:PlatformError?) in
//
//                DispatchQueue.global(qos: .userInitiated).async {
//
//                    // for inventoryTransferError object
//                    if let arrayInventory = result?.inventoryTransferError, arrayInventory.count > 0 {
//                        for obj in arrayInventory {
//
//                           //print(obj.request?.id ?? "",obj.error ?? "")
//                            let modelInvetry = RealmManager().read(type: ModelInventoryTransfers.self, primaryKey: (obj.request?.id)!)
//                                modelInvetry?.putBulkError = obj.error ?? ""
//                                modelInvetry?.updated = false
//                                RealmManager().write(table: modelInvetry!)
//                             // print(RealmManager().read(type: ModelInventoryTransfers.self, primaryKey: (obj.request?.id)!))
//                        }
//
//                    }else{
//                         let modelInventryTransfer2 = realmManager.readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true && putBulkError = ''")
//                         for model in modelInventryTransfer2 {
//                            model.updated = false
//                        }
//                        realmManager.write(modelInventryTransfer2)
//                    }
//
//                    // for invoice object
//                    if let arrayInvoice = result?.invoiceError, arrayInvoice.count > 0{
//
//                        for obj in arrayInvoice {
//                            //print(obj.request?.id ?? "",obj.error ?? "")
//                            let modelInvoice = RealmManager().read(type: ModelInvoice.self, primaryKey: (obj.request?.id)!)
//                            modelInvoice?.putBulkError = obj.error ?? ""
//                            modelInvoice?.updated = false
//
//                            //Write Payment
//                            let modelPaymentInfo = modelInvoice?.paymentInfo
//                            for objInfo in modelPaymentInfo!{
//                                objInfo.updated = false
//                            }
//
//                            //Write Shipment
//                            let modelShipment = modelInvoice?.shippingManifests
//                            for objInfo in modelShipment!{
//                                objInfo.updated = false
//                            }
//
//                            RealmManager().write(table: modelInvoice!)
//                            //print(RealmManager().read(type: ModelInvoice.self, primaryKey: (obj.request?.id)!))
//                        }
//
//                    }else{
//                        let modelInvoice2 = realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true && putBulkError = ''")
//                        for model in modelInvoice2 {
//                            model.updated = false
//
//                            //Write Payment
//                            let modelPaymentInfo = model.paymentInfo
//                            for objInfo in modelPaymentInfo{
//                                objInfo.updated = false
//                            }
//
//                            //Write Shipment
//                            let modelShipment = model.shippingManifests
//                            for objInfo in modelShipment{
//                                objInfo.updated = false
//                            }
//                        }
//
//                        realmManager.write(modelInvoice2)
//                    }
//
//
//                    // for purchaseOrder object
//                    if let arrayPo = result?.poError, arrayPo.count > 0{
//
//                        for obj in arrayPo {
//                            //print(obj.request?.id ?? "" ,obj.error ?? "")
//                            let modelPo = RealmManager().read(type: ModelPurchaseOrder.self, primaryKey: (obj.request?.id)!)
//                            modelPo?.putBulkError = obj.error ?? ""
//                            modelPo?.updated = false
//                            RealmManager().write(table: modelPo!)
//                           // print( RealmManager().read(type: ModelPurchaseOrder.self, primaryKey: (obj.request?.id)!))
//                        }
//
//                    }else{
//                         let modelPurchaseOrders2 = realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true && putBulkError = ''")
//                         for model in modelPurchaseOrders2 {
//                            model.updated = false
//                         }
//                         realmManager.write(modelPurchaseOrders2)
//                    }
//
//                    DispatchQueue.main.async {
//                        self.resync()
//                        return
//                    }
//                }
//            }
        
    }
    
    //Get bulk data and write realm models
    private func syncGetBulkData() {
        //Set boll var in user default i.e synch start
        UserDefaults.standard.set(true, forKey: "isSynchStart")
        EventBus.sharedBus().publishMain(EventBusEventType.STARTSYNCDATA)
        
        WebServicesAPI.sharedInstance().BulkAPI(request: RequestGetBulkAPI()) { (result:ResponseBulkRequest?,error:PlatformError?) in
            if error != nil{
                //print(error?.message! ?? "Error")
                UtilPrintLogs.requestLogs(message: DLogMessage.Error.rawValue, objectToPrint:error?.message! ?? "Error" )
                self.finishSync()
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let arrayPurchaseOrders = result?.purchaseOrder?.values {
                    self.savePurchaseOrder(arrayPurchaseOrders)
                }
                if let arrayInvoices = result?.invoice?.values {
                    self.saveDataInvoice(jsonData: arrayInvoices)
                }
                if let arayTransfers = result?.inventoryTransfers?.values {
                    self.saveDataInventory(jsonData: arayTransfers)
                }
                if let arrayProducts = result?.product?.values{
                    self.saveDataProduct(jsonData: arrayProducts)
                }
                if let arrayInventory = result?.inventories{
                    self.saveInventory(jsonData: arrayInventory)
                }
                if let driverInfo = result?.employees?.values {
                    self.saveDriverData(driverInfo)
                } else {
                    self.saveDriverData([])
                }
                self.finishSync()
            }
        }
    }
    
    private func resync() {
        isUpdating = false
        syncData()
    }
    
    private func finishSync() {
        //Remove object from default synch finish
        UserDefaults.standard.removeObject(forKey: "isSynchStart")
        
        //Write Log Finish Sync
        UtilWriteLogs.writeLog(timesStamp: UtilWriteLogs.curruntDate, event:activityLogEvent.LastSync.rawValue , objectId:nil, lastSynch:UtilWriteLogs.curruntDate)
        
        SKActivityIndicator.dismiss()
        EventBus.sharedBus().publishMain(EventBusEventType.FINISHSYNCDATA)
        isUpdating = false
    }
    
    private func savePurchaseOrder(_ arrayPurchase: [ResponsePurchaseOrder]){
        let poErrorObject = RealmManager().readPredicate(type: ModelPurchaseOrder.self, predicate: "putBulkError != ''")
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(ModelPurchaseOrder.self))
        }
        for respPurchaseOrder in arrayPurchase {
            let canSkip : Bool = false
//            if poErrorObject.count != 0{
//                for obj in poErrorObject{
//                    if obj.id == respPurchaseOrder.id{
//                        canSkip = true
//                    }
//                }
//            }
            
            //Check skip condition
            if(canSkip == false){
                let modelPurcahseOrder:ModelPurchaseOrder = ModelPurchaseOrder()
                modelPurcahseOrder.id = respPurchaseOrder.id
                modelPurcahseOrder.origin = respPurchaseOrder.parentPONumber ?? ""
                modelPurcahseOrder.purchaseOrderNumber = respPurchaseOrder.poNumber
                modelPurcahseOrder.isMetRc = respPurchaseOrder.metrc ?? false
                modelPurcahseOrder.received = respPurchaseOrder.receivedDate ?? 0
                modelPurcahseOrder.completedDate = respPurchaseOrder.completedDate ?? 0
                modelPurcahseOrder.status = respPurchaseOrder.purchaseOrderStatus
                
                if let listProdReq = respPurchaseOrder.poProductRequestList {
                    
                    for productReq in listProdReq {
                        let modelPOProduct = ModelPurchaseOrderProduct()
                        modelPOProduct.id   = productReq.id
                        modelPOProduct.productId = productReq.productId
                        modelPOProduct.name = productReq.productName
                        modelPOProduct.quantity = productReq.requestQuantity ?? 0
                        modelPOProduct.batchId = productReq.batchId
                        modelPOProduct.unitPrice = productReq.unitPrice ?? 0
                        modelPOProduct.totalCost = productReq.totalCost ?? 0
                        modelPOProduct.status = productReq.status ?? ""
                        
                        modelPOProduct.discount = productReq.discount ?? 0
                        modelPOProduct.exciseTax = productReq.exciseTax ?? 0
                        modelPOProduct.totalExciseTax = productReq.totalExciseTax ?? 0
                        modelPOProduct.totalCultivationTax = productReq.totalCultivationTax ?? 0
                        
                
                        modelPurcahseOrder.productInShipment.append(modelPOProduct)
                    }
                }
                
                //Write to database
                RealmManager().write(table: modelPurcahseOrder)
            }
        }
    }
    
    private func saveDriverData(_ arrayDriver: [ResponceDriverInfo]){
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(ModelDriverInfo.self))
        }
        
        for response in arrayDriver{
            let model: ModelDriverInfo = ModelDriverInfo()
            model.id = response.id
            model.driverId = response.id
            model.driverName = response.firstName
            model.driverLastName = response.lastName
            model.driversLicense = response.driversLicense
            model.vehicleMake = response.vehicleMake
            model.vehicleModel = response.vehicleModel
            model.vehicleColor = response.vehicleColor
            model.vehicleLicensePlate = response.vehicleLicensePlate
            model.active = response.active ?? false
            model.deleted = response.deleted ?? false
            model.companyId = response.companyId
            RealmManager().write(table: model)
        }
        //print(RealmManager().readList(type: ModelDriverInfo.self))
        UtilPrintLogs.requestLogs(message:"DriverInfo", objectToPrint:RealmManager().readList(type: ModelDriverInfo.self))
    }
    
    fileprivate func saveDataInvoice(jsonData: [ResponseInvoice]?){
        let invoiceErrorObject = RealmManager().readPredicate(type: ModelInvoice.self, predicate: "putBulkError != ''")
        if let values = jsonData{
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.delete(realm.objects(ModelInvoice.self))
            }
            
            for value in values{
                let canSkip : Bool = false
//                if invoiceErrorObject.count != 0{
//                    for obj in invoiceErrorObject{
//                        if obj.id == valu.id{
//                            canSkip = true
//                        }
//                    }
//                }
               //Cehck Skip Condition
                if (canSkip == false){
                    let model: ModelInvoice = ModelInvoice()
                    model.id                = value.id
                    model.created           = value.created ?? 0
                    model.modified          = value.modified ?? 0
                    model.invoiceStatus     = value.invoiceStatus
                    model.invoicePaymentStatus = value.invoicePaymentStatus
                    model.companyId         = value.companyId
                    model.customerId        = value.customerId
                    model.invoiceNumber     = value.invoiceNumber
                    model.dueDate           = DateFormatterUtil.format(dateTime: (Double(DateIntConvertUtil.convert(dateTime: value.dueDate ?? 0, type: DateIntConvertUtil.Seconds))),format: DateFormatterUtil.mmddyyyy)
                    model.balanceDue        = value.balanceDue!
                    model.vendorCompany     = value.vendor?.name
                    model.balanceDue        = value.balanceDue!
                    model.contact           = value.vendor?.phone
                    model.total             = value.total!
                    
                    model.vendorLicenseNumber = value.vendor?.licenseNumber
                    model.vendorCompanyType = value.vendor?.companyType
                    model.vendorPhone = value.vendor?.phone
                    model.vendorAddress = value.vendor?.address?.address
                    model.vendorCity = value.vendor?.address?.city
                    model.vendorState = value.vendor?.address?.state
                    model.vendorZipcode = value.vendor?.address?.zipCode
                    model.vendorCountry = value.vendor?.address?.country
                    model.salesPerson = value.salesPerson
                    
                    
                    
                    if let remaingProducts = value.remainingProductInformations{
                        for remProd  in remaingProducts{
                            let temp               = ModelRemainingProduct()
                            temp.id                = HexGenerator.sharedInstance().generate()
                            temp.productId         = remProd.productId
                            temp.productName       = remProd.productName
                            temp.requestQuantity   = remProd.requestQuantity!
                            temp.remainingQuantity = remProd.remainingQuantity!
                            model.remainingProducts.append(temp)
                        }
                    }else{
                        
                        //  print("Remaing nil..")
                    }
                    ///Mapping Items
                    if let items = value.items{
                        for item in items{
                            let itemTemp = ModelInvoiceItems()
                            itemTemp.id  = HexGenerator.sharedInstance().generate()
                            itemTemp.productId = item.productId
                            itemTemp.orderItemId = item.orderItemId
                            itemTemp.productName = item.productName
                            itemTemp.batchId    = item.batchId
                            itemTemp.quantity = item.quantity
                            model.items.append(itemTemp)
                            
                        }
                        
                    }else{
                        //  print("Items nil")
                    }
                    //Mapping Payment Info
                    if let  paymentRec = value.paymentsReceived{
                        
                        for payment in paymentRec{
                            let paymentTemp             = ModelPaymentInfo()
                            paymentTemp.id              = payment.id
                            paymentTemp.paymentDate     = payment.paidDate!
                            paymentTemp.referenceNumber = payment.referenceNo ?? ""
                            paymentTemp.amount          = payment.amountPaid!
                            paymentTemp.notes           = payment.notes?.message
                            paymentTemp.paymentType     = payment.paymentType ?? ""
                            paymentTemp.paymentNo = payment.paymentNo
                            model.paymentInfo.append(paymentTemp)
                        }
                    } else {
                        //  print("Payment info nil")
                    }
                    ///Mapping Shipping Manifests
                    if value.shippingManifests != nil, value.shippingManifests!.count > 0 {
                        
                        for ship in value.shippingManifests! {
                            let shipMen                 = ModelShipingMenifest()
                            shipMen.id                  = ship.id
                            shipMen.companyId           = ship.companyId
                            shipMen.driverName          = ship.driverName
                            shipMen.driverLicenseNumber = ship.driverLicenceNumber
                            shipMen.vehicleMake         = ship.vehicleMake
                            shipMen.vehicleModel        = ship.vehicleModel
                            shipMen.vehicleLicensePlate = ship.vehicleLicensePlate
                            //shipMen.signaturePhoto      = ship.signaturePhoto
                            shipMen.receiverCompany     = ship.receiverCompany?.name
                            shipMen.receiverType        = ship.receiverCompany?.vendorType
                            shipMen.receiverContact     = ship.receiverCompany?.phone
                            shipMen.receiverLicense     = ship.receiverCompany?.licenseNumber
                            shipMen.invoiceStatus       = ship.invoiceStatus
                            shipMen.shippingManifestNo  = ship.shippingManifestNo
                            shipMen.deliveryDate        = ship.deliveryDate ?? 0
                            shipMen.deliveryTime        = ship.deliveryTime ?? 0
                            
                            if let sigAsset = ship.signaturePhoto{
                               //Write signature assets
                                let signature = ModelSignatureAsset()
                                signature.id = HexGenerator.sharedInstance().generate()
                                signature.assetType = sigAsset.assetType
                                signature.mediumURL = sigAsset.mediumURL
                                signature.largeURL  = sigAsset.largeURL
                                signature.publicURL = sigAsset.publicURL
                                signature.thumbURL  = sigAsset.thumbURL
                                signature.key       = sigAsset.key
                                
                                shipMen.signatureAsset = signature
                            }
                            
                            //For remaining product info
                            if let prodMetrictInfo = ship.productMetrcInfo{
                                
                                for prodInfo in prodMetrictInfo{
                                    //Write product metric info
                                    let objProdInfo = ModelProductMetrcInfo()
                                    objProdInfo.id = HexGenerator.sharedInstance().generate()
                                    objProdInfo.productId = prodInfo.productId
                                    objProdInfo.orderItemId = prodInfo.orderItemId
                                    objProdInfo.quantity = prodInfo.quantity ?? 0
                                    
                                    if let batchDetails = prodInfo.batchDetails{
                                        for batch in batchDetails{
                                            //Write batch details
                                            let objbatch = ModelBatchDetails()
                                            objbatch.id = HexGenerator.sharedInstance().generate()
                                            objbatch.batchId = batch.batchId
                                            objbatch.batchSku = batch.batchSku
                                            objbatch.metrcLabel = batch.metrcLabel
                                            objbatch.prepackageItemId = batch.prepackageItemId
                                            objbatch.overrideInventoryId = batch.overrideInventoryId
                                            objbatch.quantity = batch.quantity ?? 0
                                            
                                            objProdInfo.batchDetailsList.append(objbatch)
                                        }
                                    }
                                   shipMen.productMetrcInfoList.append(objProdInfo)
                                }
                             
                            }
                            
                            if let add = ship.receiverAddress?.address{
                                shipMen.receiverAddress?.id      = add.id
                                shipMen.receiverAddress?.city    = add.city
                                shipMen.receiverAddress?.address = add.address
                                shipMen.receiverAddress?.state   = add.state
                            }
                            
                            if let add = ship.shipperInformation{
                                shipMen.shippercompanyId     = add.companyId
                                shipMen.shippercustomerCompanyId    = add.customerCompanyId
                                shipMen.shippercompanyContactId = add.companyContactId
                            }
                            
                            model.shippingManifests.append(shipMen)
                        }
                    }
                    else{
                        //  print("From json shipingMenifest: Nil")
                    }
                    RealmManager().write(table: model)
                }
               
            }
        }
       // print("---Invoice Data Save---")
        
    }
    
    fileprivate func saveDataInventory(jsonData: [ResponseInventoryTransfers]?){
        
        //let inventryErrorObject = RealmManager().readPredicate(type: ModelInventoryTransfers.self, predicate: "putBulkError != ''")
        if let values = jsonData{
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(realm.objects(ModelInventoryTransfers.self))
            }
            
            for value in values{
                var canSkip : Bool = false
//                if inventryErrorObject.count != 0{
//                    for obj in inventryErrorObject{
//                        if obj.id == value.id{
//                            canSkip = true
//                        }
//                    }
//                }
                

                let items =  RealmManager().readPredicate(type: ModelInventoryTransfers.self,
                                             predicate: "id = '\(value.id!)'")
                if(items.count > 0){
                    //Check if items exist with same id
                    //If yes, there should be only one item, because id is Unique
                    //Check if there is putBulkError in in this item
                    //If there is putBulkError then skip this item
                    let existingInventoryItem = items[0]
                    if(!TextHelpers.isEmpty(existingInventoryItem.putBulkError)){
                        canSkip = true
                    }
                }else if let oldId = value.oldId, !TextHelpers.isEmpty(oldId){
                    //If item does not exist with same id
                    //This means it is a new item or new entry of existing item on server
                    //If it is new entry of existing item, we will get oldId
                    //If oldId exist, delete this oldId object to avoid duplicacy
                    RealmManager().deletePredicate(type: ModelInventoryTransfers.self,
                                                   predicate: "id = '\(oldId)'")
                }

                
 
                //Check Skip condition
                if canSkip == false {
                    let tempInventory = ModelInventoryTransfers()
                    tempInventory.id = value.id
                    tempInventory.transferNo = value.transferNo
                    tempInventory.modified = value.modified ?? 0
                    tempInventory.fromInventoryName = value.fromInventoryName
                    tempInventory.fromShopName = value.fromShopName
                    tempInventory.toInventoryName = value.toInventoryName
                    tempInventory.toShopId = value.toShopId
                    tempInventory.fromInventoryId = value.fromInventoryId
                    tempInventory.toInventoryId = value.toInventoryId
                    tempInventory.completeTransfer = value.completeTransfer ?? false
                    tempInventory.toShopName = value.toShopName
                    tempInventory.toInventoryName = value.toInventoryName
                    tempInventory.createdByEmployeeName = value.createdByEmployeeName
                    tempInventory.status = value.status
                    
                    if let translog = value.transferLogs{
                        for product in translog{
                            let invModel = ModelTransferLogs()
                            invModel.id = HexGenerator.sharedInstance().generate()
                            invModel.productId = product.productId
                            invModel.transferAmount = product.transferAmount ?? 00
                            invModel.prepackageName = product.prepackageName ?? "__"
                            tempInventory.transferLogs.append(invModel)
                        }
                    }
                    

                    RealmManager().write(table: tempInventory)
                }
            }
        }else{
            UtilPrintLogs.requestLogs(message:"Inventory is nil....", objectToPrint: nil)
            //print("Inventory is nil....")
        }
        UtilPrintLogs.requestLogs(message:"---Inventory Data Save---", objectToPrint: nil)
        //print("---Inventory Data Save---")
    }
    
    fileprivate func saveDataProduct(jsonData:[ResponseProduct]?){
        //RealmManager.deleteAll(ModelProduct.self)
        
        if let products = jsonData{
            let realm = try! Realm()
            
            try! realm.write {
                realm.delete(realm.objects(ModelProduct.self))
            }
            
            for prod in products{
                
                if let tempQuantity = prod.quantities{
                    if tempQuantity.count > 0{
                    //Calcualte total quty.
                    var totoalQt:Int = 0
                    for qut in tempQuantity{
                        totoalQt += Int(qut.quantity ?? 0)
                    }
                   
                    //Write product
                    for qut in tempQuantity{
                        let temp  = ModelProduct()
                        temp.id = HexGenerator.sharedInstance().generate()
                        temp.productId = prod.id
                        temp.sku = prod.sku
                        temp.name = prod.name
                        temp.companyLinkId = prod.companyLinkId
                        temp.shopId = qut.shopId
                        temp.inventoryId = qut.inventoryId
                        temp.quantity = qut.quantity ?? 0
                        temp.totalQuantity = Double(totoalQt)
                        
                        RealmManager().write(table: temp)
                    }
                    
                    //print(RealmManager().readList(type: ModelProduct.self))
                    UtilPrintLogs.requestLogs(message:DLogMessage.ProductData.rawValue, objectToPrint: RealmManager().readList(type: ModelProduct.self))
                    }
                else{
                    //if product has no qty
                    let temp  = ModelProduct()
                    temp.id = HexGenerator.sharedInstance().generate()
                    temp.productId = prod.id
                    temp.sku = prod.sku
                    temp.name = prod.name
                    temp.companyLinkId = prod.companyLinkId
                    temp.shopId = prod.shopId
                    temp.inventoryId = HexGenerator.sharedInstance().generate()
                    temp.quantity = 0.0
                    temp.totalQuantity = 0.0
                    RealmManager().write(table: temp)
                }
    
            }
          }
        }else{
            print("---Products nil---")
        }
    }
    fileprivate func saveInventory(jsonData:[ResponseInventories]){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(ModelInventories.self))
        }
        
        let shops:[ShopsModel] = RealmManager().readList(type: ShopsModel.self)
        for inventories in jsonData{
           let model = ModelInventories()
            //print(inventories.shopId ?? "-Empty-")
            for shop in shops{
                if shop.id == inventories.shopId{
                       model.shopName = shop.name
                        model.shopId   = inventories.shopId
                       for ivt in inventories.inventory!{
                    
                                let invModel = ModelInventory()
                                invModel.id = ivt.id
                                invModel.name = ivt.name
                                invModel.shopId = ivt.shopId
                                model.inventory.append(invModel)
                    
                        }
        
                }
            }
             RealmManager().write(table: model)
            UtilPrintLogs.requestLogs(message:"---ResponseInventories Save---", objectToPrint: nil)
             //print("---ResponseInventories Save---")
        }
    }
}



