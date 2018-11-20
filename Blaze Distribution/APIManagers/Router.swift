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
    case bulkGet()
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
    
    
    //===========================================================================================
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let (method, path, requestJson, params): (Method, String, Data?, [String:Any]?) = getRouterInfo()
        
        let URL = Foundation.URL(string: Router.baseURLString)!
        var request = URLRequest(url: URL.appendingPathComponent(path))
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
            return (Method.POST,"api/v1/mgmt/session",encode(request),nil)
        case .bulkGet():
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
        }
       
    }
    func encode <T: BaseRequest>(_ requestObj: T) -> Data?{
        return try? JSONEncoder().encode(requestObj)
    }
}
