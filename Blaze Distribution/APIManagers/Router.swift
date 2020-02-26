import Foundation
import Alamofire

public enum Method: String {
    case OPTIONS = "OPTIONS"
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case TRACE = "TRACE"
    case CONNECT = "CONNECT"
}


enum Router : URLRequestConvertible {
    static var baseURLString = ""
    static let perPage = 30
    
    // authentications
    case sessionLogin(request: RequestLogin)
    //BulkAPI
    case bulkGet
    
    //Get all batches by product id
    case getAllBatchesByProdId(request : RequestGetallBatches)
    //get all inventorise
    case getAllInventory
    //get product by id
    case getProductById(request: RequestProdutById)
    //BulkPostAPI
    case bulkPost(request: RequestPostModel)
    //SwitchShopPostAPI
    case SwitchShopPost(request: RequestSwitchShop)
    //Forgot Password
    case forgotPassword(request: RequestForgotPassword)
    //uploadSignatureApi
    case uploadSignature(request: RequestSignature)
    // update transfer status
    case updateTransferStatusById(request: RequestUpdateTransferStatus)
    // prepare invoice
    case prepareInvoice(request: RequestCreateInvoice)
    // prepare invoice
    case createInvoice(request: RequestCreateInvoice)
    //get all vendor list
    case getAllVendor(request: RequestGetAllVendor)
    //get company contact name
    case getCompanyContactList(request: RequestGetCompanyContact)
    //get product by sku
    case getProductByBatchSKU(request: RequestProductByBatchSku)
    //get products by shopId
    case getProductsByShopId(request: RequestProductByShopId)
    
    //===========================================================================================
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let (method, path, requestJson, params): (Method, String, Data?, [String:Any]?) = getRouterInfo()
        
        let urlstring1 =  Router.baseURLString+path
        let urlString = urlstring1.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let URL = Foundation.URL(string: urlString!)!
        var request = URLRequest(url: URL)
        request.httpMethod = method.rawValue 
        if let requestJson = requestJson {
                let jsonData = requestJson
                request.httpBody = jsonData
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let sessionToken = UtilityUserDefaults.sharedInstance().getToken(){
            let sessionData = "Token \(sessionToken)"
            request.setValue(sessionData, forHTTPHeaderField: "Authorization")
        }
     
        return try Alamofire.URLEncoding.default.encode(request, with: params)
    }
    
    func getRouterInfo () -> (Method,String,Data?,[String:Any]?) {
        
        switch(self) {
        // SESSIONS
        case .sessionLogin(let request):
            return (Method.POST,"/api/v1/mgmt/session",encode(request),nil)
        case .bulkGet:
            return (Method.GET,"/api/v1/warehouse/mgmt/dataSync",nil,nil)
        case .getProductById(let request):
            return (Method.GET,"/api/v1/mgmt/products/\(request.productId ?? "")",nil,nil)
        case .bulkPost(let request):
            return (Method.PUT,"/api/v1/warehouse/mgmt/dataSync",encode(request),nil)
        case .SwitchShopPost(let request):
            return (Method.POST,"/api/v1/mgmt/session/shop",encode(request),nil)
        case.forgotPassword(let request):
            return (Method.POST,"/api/v1/mgmt/password/reset",encode(request),nil)
        case.uploadSignature(let request):
            return (Method.POST,"/api/v1/mgmt/assets/photo",encode(request),nil)
        case .updateTransferStatusById(let request):
            return (Method.POST,"/api/v1/mgmt/inventory/\(request.transferId ?? "")/inventoryHistory",encode(request),nil)
        case .prepareInvoice(let request):
            return (Method.POST,"/api/v1/warehouse/mgmt/invoice/prepareInvoice",encode(request),nil)
        case .createInvoice(let request):
            return (Method.POST,"/api/v1/warehouse/mgmt/invoice",encode(request),nil)
        
        case .getAllInventory:
            return (Method.GET,"/api/v1/mgmt/inventory",nil,nil)
            
        case .getAllBatchesByProdId(let request):
            return (Method.GET,"/api/v1/mgmt/batch/list?productId=\(request.productId ?? "")",nil,nil)
        case .getAllVendor:
            return (Method.GET,"/api/v1/mgmt/vendors?companyType=&limit=1000&start=0&term=&type=BOTH&vendorId=&currentTimeStamp=",nil,nil)
        case .getCompanyContactList(let request):
            return (Method.GET,"/api/v1/mgmt/customerCompany/contact/list?start=0&limit=0&customerCompanyId=\(request.customerCompanyId ?? "")",nil,nil)
            
        case .getProductByBatchSKU(let request):
            return (Method.GET,"/api/v1/mgmt/products/productByBatchSKU?batchSKU=\(request.batchSku ?? "")",nil,nil)
            
        case .getProductsByShopId(let request):
            return (Method.GET, "/api/v1/mgmt/products?shopId=\(request.shopId ?? "")&status=Active",nil,nil)
            
        }
        
       
    }
    
    func encode <T: BaseRequest>(_ requestObj: T) -> Data? {
        return try? JSONEncoder().encode(requestObj)
    }
}
