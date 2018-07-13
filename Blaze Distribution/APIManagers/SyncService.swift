import Foundation
import RealmSwift

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
            
            if self.isSignatureAvailable() {
                
                self.syncSignature()
                
            }else if self.isPostBulkAvailable() {
                
               self.syncPostBulkData()
                
            }else{
                self.syncGetBulkData()
            }
       
        
    }
    
    private func isSignatureAvailable() -> Bool {
        return getModelSignature().count > 0
    }
    
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
    
    private func syncSignature() {
        //Get image one by one from ModelSignature
        let arrayModelSignature = getModelSignature()
        //print("arrayModelSignature.count : \(arrayModelSignature.count)")
        if arrayModelSignature.count <= 0 {
            self.resync()
        }
        
        let modelSign = arrayModelSignature[0]
        let requestSignature = RequestSignature()
        requestSignature.name = modelSign.name
        requestSignature.invoiceId = modelSign.invoiceId
        requestSignature.shippingMainfestId = modelSign.shippingMainfestId
  
        WebServicesAPI.sharedInstance().uploadSignature(request: requestSignature) {
            (result:ResponseAsset?, _ error:PlatformError?) in
            
            if result == nil {
                self.resync()
                return
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
                    RealmManager().deletePredicate(type: ModelSignature.self, predicate: "id = '\(modelSign.id!)'")
                    break
                }
            }
            
            DispatchQueue.main.async {
                self.resync()
            }
        }
        

    }
 
    private func syncPostBulkData(){
 
            ///After API complete call resync, so syncdata can run recursively
            let realmManager: RealmManager = RealmManager()
            let modelPurchaseOrders = realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true && putBulkError = ''")
            let modelInventryTransfer = realmManager.readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true && putBulkError = ''")
            let modelInvoice = realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true && putBulkError = ''")
 
            
            let requestModel = RequestPostModel()
            
            //For Model purchase order
            for model in modelPurchaseOrders {
                print("modelPurchaseOrders")
                let requestPurchase: RequestPurchaseOrder = RequestPurchaseOrder()
                requestPurchase.id = model.id
                requestPurchase.purchaseOrderNumber = model.purchaseOrderNumber
                requestPurchase.isMetRc = model.isMetRc
                requestPurchase.metrcId = model.metrcId
                requestPurchase.status = model.status
                requestPurchase.origin = model.origin
                requestPurchase.received = model.received
                requestPurchase.completedDate = model.completedDate
                
                for productReceived in model.productReceived {
                    let requestPurchaseOrderReceived: RequestPurchaseOrderProductReceived = RequestPurchaseOrderProductReceived()
                    requestPurchaseOrderReceived.id = productReceived.id
                    requestPurchaseOrderReceived.productId = productReceived.id
                    requestPurchaseOrderReceived.name = productReceived.name
                    requestPurchaseOrderReceived.requestQuantity = productReceived.expected
                    requestPurchaseOrderReceived.receivedQuantity = productReceived.received
                    requestPurchase.poProductRequestList.append(requestPurchaseOrderReceived)
                }
                requestModel.purchaseOrder.append(requestPurchase)
            }
            
            //For Model Inventry Transfer
            for model in modelInventryTransfer {
                print("modelInventryTransfer")
                let requestInventry: RequestInventry = RequestInventry()
                requestInventry.id = model.id
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
                
                
                for productInCart in model.slectedProducts {
                    let requestCartProduct: RequestCartProduct = RequestCartProduct()
                    requestCartProduct.name = productInCart.name
                    requestCartProduct.productId = productInCart.batchId
                    requestCartProduct.transferAmount = productInCart.quantity
                    requestInventry.transferLogs.append(requestCartProduct)
                }
                requestModel.inventoryTransfer.append(requestInventry)
            }
            
            
            //For Model Invoice
            for model in modelInvoice {
                print("modelInvoice")
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
                    requestModelInvoicePayment.paymentType = PyamentType.Cash.rawValue
                    let notesModel: pyamentNotes = pyamentNotes()
                    notesModel.message = payment.notes
                    requestModelInvoicePayment.notes = notesModel
                    
                    requestInvoice.addPaymentRequest.append(requestModelInvoicePayment)
                }
                
                //List shipping mainfest
                for shiping in model.shippingManifests {
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
                    requestSipperInfo.companyId = model.companyId
                    requestModelShippingMainfest.shipperInformation = requestSipperInfo
                    
                    let requestReciverInfo : RequestReceiverInformation = RequestReceiverInformation()
                    requestReciverInfo.customerCompanyId = model.customerId
                    requestModelShippingMainfest.receiverInformation = requestReciverInfo
                    
                    //add shiping selected items
                    //Payment info list
                    for selectedItem in shiping.selectedItems {
                        let requestSelectedItemsShipping: RequestShippingMainfestSelectedItem = RequestShippingMainfestSelectedItem()
                        requestSelectedItemsShipping.productId = selectedItem.productId
                        //requestSelectedItemsShipping.productName = selectedItem.productName
                        //requestSelectedItemsShipping.remainingQuantity = selectedItem.remainingQuantity
                        requestSelectedItemsShipping.quantity = selectedItem.requestQuantity
                        //requestSelectedItemsShipping.isSelected = selectedItem.isSelected
                        requestModelShippingMainfest.productMetrcInfo.append(requestSelectedItemsShipping)
                    }
                    
                    requestInvoice.addShippingManifestRequest.append(requestModelShippingMainfest)
                    
                }
                
                requestModel.invoice.append(requestInvoice)
            }
            
            WebServicesAPI.sharedInstance().BulkPostAPI(request: requestModel) {
                (result:ResponseBulkRequest?,error:PlatformError?) in
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    // for inventoryTransferError object
                    if let arrayInventory = result?.inventoryTransferError, arrayInventory.count > 0{
                        for obj in arrayInventory {
                            
                           print(obj.request?.id ?? "",obj.error ?? "")
                            let modelInvetry = RealmManager().read(type: ModelInventoryTransfers.self, primaryKey: (obj.request?.id)!)
                                modelInvetry?.putBulkError = obj.error ?? ""
                                RealmManager().write(table: modelInvetry!)
                             // print(RealmManager().read(type: ModelInventoryTransfers.self, primaryKey: (obj.request?.id)!))
                        }
                        
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
                            print(obj.request?.id ?? "",obj.error ?? "")
                            let modelInvoice = RealmManager().read(type: ModelInvoice.self, primaryKey: (obj.request?.id)!)
                            modelInvoice?.putBulkError = obj.error ?? ""
                            RealmManager().write(table: modelInvoice!)
                            //print(RealmManager().read(type: ModelInvoice.self, primaryKey: (obj.request?.id)!))
                        }
                        
                    }else{
                        let modelInvoice2 = realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true && putBulkError = ''")
                        for model in modelInvoice2 {
                            model.updated = false
                        }
                        realmManager.write(modelInvoice2)
                    }
                    
                    // for purchaseOrder object
                    if let arrayPo = result?.poError, arrayPo.count > 0{
                        
                        for obj in arrayPo {
                            print(obj.request?.id ?? "" ,obj.error ?? "")
                            let modelPo = RealmManager().read(type: ModelPurchaseOrder.self, primaryKey: (obj.request?.id)!)
                            modelPo?.putBulkError = obj.error ?? ""
                            RealmManager().write(table: modelPo!)
                           // print( RealmManager().read(type: ModelPurchaseOrder.self, primaryKey: (obj.request?.id)!))
                        }
                        
                    }else{
                         let modelPurchaseOrders2 = realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true && putBulkError = ''")
                         for model in modelPurchaseOrders2 {
                            model.updated = false
                         }
                         realmManager.write(modelPurchaseOrders2)
                    }
                    

//                    print("======================")
//
//                    let realmManager = RealmManager()
//
//                    let modelPurchaseOrders2 = realmManager.readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true")
//                    let modelInventryTransfer2 = realmManager.readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true")
//                    let modelInvoice2 = realmManager.readPredicate(type: ModelInvoice.self, predicate: "updated = true")
//
//                    for model in modelPurchaseOrders2 {
//                        model.updated = false
//                    }
//                    for model in modelInventryTransfer2 {
//                        model.updated = false
//                    }
//                    for model in modelInvoice2 {
//                        model.updated = false
//                    }
//
//                    realmManager.write(modelPurchaseOrders2)
//                    realmManager.write(modelInventryTransfer2)
//                    realmManager.write(modelInvoice2)

                    DispatchQueue.main.async {
                        self.resync()
                        return
                    }
                }
            }
    }
    
    private func syncGetBulkData() {
        
        WebServicesAPI.sharedInstance().BulkAPI(request: RequestGetBulkAPI()) { (result:ResponseBulkRequest?,error:PlatformError?) in
            if error != nil{
                print(error?.message! ?? "Error")
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
                }else{
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
    
    private func finishSync(){
        EventBus.sharedBus().publishMain(EventBusEventType.SYNCDATA)
        isUpdating = false
    }
    
    private func savePurchaseOrder(_ arrayPurchase: [ResponsePurchaseOrder]){
        
        let poErrorObject = RealmManager().readPredicate(type: ModelPurchaseOrder.self, predicate: "updated = true ")
        
        for respPurchaseOrder in arrayPurchase {
            var canSkip : Bool = false
            if poErrorObject.count != 0{
                for obj in poErrorObject{
                    if obj.id == respPurchaseOrder.id{
                        canSkip = true
                    }
                }
            }
            
            //Check skip condition
            if(canSkip == false){
                let modelPurcahseOrder:ModelPurchaseOrder = ModelPurchaseOrder()
                modelPurcahseOrder.id = respPurchaseOrder.id
                modelPurcahseOrder.purchaseOrderNumber = respPurchaseOrder.poNumber
                modelPurcahseOrder.isMetRc = respPurchaseOrder.metrc ?? false
                modelPurcahseOrder.received = respPurchaseOrder.receivedDate ?? 0
                modelPurcahseOrder.completedDate = respPurchaseOrder.completedDate ?? 0
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
    
    private func saveDriverData(_ arrayDriver: [ResponceDriverInfo]){
       
        for response in arrayDriver{
            let model: ModelDriverInfo = ModelDriverInfo()
            model.id = response.id
            model.driverId = response.id
            model.driverName = response.firstName
            model.driverLastName = response.lastName
            model.driverLicenseNumber = response.driverLicenceNumber
            model.vehicleMake = response.vehicleMake
            model.vehicleModel = response.vehicleModel
            model.vehicleColor = response.vehicleColor
            model.vehicleLicensePlate = response.vehicleLicensePlate
            RealmManager().write(table: model)
        }
        
//        let model: ModelDriverInfo = ModelDriverInfo()
//        model.driverId = "jkfdafdfbkj"
//        model.driverName = "Jon Lee"
//        model.driverLicenseNumber = "785g457t87455g4"
//        model.vehicleMake = "jhdah"
//        model.vehicleModel = "truck"
//        model.vehicleColor = "red"
//        model.vehicleLicensePlate = "673vhajdwtb"
//        RealmManager().write(table: model)
        print(RealmManager().readList(type: ModelDriverInfo.self))
        
        //var dummyData = [[""]]
    }
    
    fileprivate func saveDataInvoice(jsonData: [ResponseInvoice]?){
        let invoiceErrorObject = RealmManager().readPredicate(type: ModelInvoice.self, predicate: "updated = true ")
        if let values = jsonData{
            
            for valu in values{
                var canSkip : Bool = false
                if invoiceErrorObject.count != 0{
                    for obj in invoiceErrorObject{
                        if obj.id == valu.id{
                            canSkip = true
                        }
                    }
                }
               //Cehck Skip Condition
                if (canSkip == false){
                    let model: ModelInvoice = ModelInvoice()
                    model.id                = valu.id
                    model.invoiceStatus     = valu.invoiceStatus
                    model.companyId         = valu.companyId
                    model.customerId        = valu.customerId
                    model.invoiceNumber     = valu.invoiceNumber
                    model.dueDate           = DateFormatterUtil.format(dateTime: (Double(DateIntConvertUtil.convert(dateTime: valu.dueDate ?? 0, type: DateIntConvertUtil.Seconds))),format: DateFormatterUtil.mmddyyyy)
                    model.balanceDue        = valu.balanceDue!
                    model.vendorCompany           = valu.vendor?.name
                    model.balanceDue        = valu.balanceDue!
                    model.contact           = valu.companyContact
                    model.total             = valu.total!
                    
                    model.vendorLicenseNumber = valu.vendor?.licenseNumber
                    model.vendorCompanyType = valu.vendor?.companyType
                    model.vendorPhone = valu.vendor?.phone
                    model.vendorAddress = valu.vendor?.address?.address
                    model.vendorCity = valu.vendor?.address?.city
                    model.vendorState = valu.vendor?.address?.state
                    model.vendorZipcode = valu.vendor?.address?.zipCode
                    model.vendorCountry = valu.vendor?.address?.country
                    
                    
                    
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
                        
                        //  print("Remaing nil..")
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
                        //  print("Items nil")
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
                        
                        //  print("Payment info nil")
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
                            shipMen.invoiceStatus       = ship.invoiceStatus
                            shipMen.shippingManifestNo  = ship.shippingManifestNo
                            if let add = ship.receiverAddress?.address{
                                shipMen.receiverAddress?.id      = add.id
                                shipMen.receiverAddress?.city    = add.city
                                shipMen.receiverAddress?.address = add.address
                                shipMen.receiverAddress?.state   = add.state
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
        let inventryErrorObject = RealmManager().readPredicate(type: ModelInventoryTransfers.self, predicate: "updated = true ")
        if let values = jsonData{
            
            for value in values{
                var canSkip : Bool = false
                if inventryErrorObject.count != 0{
                    for obj in inventryErrorObject{
                        if obj.id == value.id{
                            canSkip = true
                        }
                    }
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
                    tempInventory.status = value.status
                    
                    RealmManager().write(table: tempInventory)
                }
            }
        }else{
            print("Inventory is nil....")
        }
        print("---Inventory Data Save---")
    }
    
    fileprivate func saveDataProduct(jsonData:[ResponseProduct]?){
        //RealmManager.deleteAll(ModelProduct.self)
        
        if let products = jsonData{
            
            for prod in products{
                if let tempQuantity = prod.quantities{
                    for qut in tempQuantity{
                        let temp  = ModelProduct()
                        temp.id = HexGenerator.sharedInstance().generate()
                        temp.productId = prod.id
                        temp.name = prod.name
                        temp.companyLinkId = prod.companyLinkId
                        temp.shopId = qut.shopId
                        temp.inventoryId = qut.inventoryId
                        temp.quantity = qut.quantity ?? 0
                        RealmManager().write(table: temp)
                    }
                    
                    print(RealmManager().readList(type: ModelProduct.self))
                }
            }
        }else{
            print("---Products nil---")
        }
    }
    fileprivate func saveInventory(jsonData:[ResponseInventories]){
        
        let shops:[ShopsModel] = RealmManager().readList(type: ShopsModel.self)
        
        
        for inventories in jsonData{
           let model = ModelInventories()
            print(inventories.shopId ?? "-Empty-")
            
            
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
             print("---ResponseInventories Save---")
        }
    }
}



