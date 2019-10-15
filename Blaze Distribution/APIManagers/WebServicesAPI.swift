import UIKit
import Alamofire
import Foundation
import Realm
import RealmSwift

class WebServicesAPI: NSObject {
    
    private override init(){
        Router.baseURLString = DistributionConfig.sharedInstance().getAppUrl()
    } 
    
    private static var webServiceAPI:WebServicesAPI!
    
    public static func sharedInstance() -> WebServicesAPI{
        if webServiceAPI == nil {
            webServiceAPI = WebServicesAPI()
        }
        return webServiceAPI
    }
    
    fileprivate func makeRequest<T:BaseResponseModel>(_ request:Router, callback:@escaping (_ result:T?,_ error:PlatformError?)-> Void) {
        
        self.printRequest(urlData: request.getRouterInfo(), nil)
        
        Alamofire.request(request)
            .responseJSON { (response:DataResponse<Any>) in
                let data = response.result.value
                
                if let res = response.response {
                    
                    self.printRequest(urlData: request.getRouterInfo(), data)
                    
                    do {
                        let headers = res.allHeaderFields
                        if let tokenHeader:String = headers["X-Auth-Token"] as? String {
                            UtilityUserDefaults.sharedInstance().saveToken(strToken: tokenHeader)
                        }
                        print("RESPONSE StatusCode:",res.statusCode)
                        if (res.statusCode == 200 || res.statusCode == 204) {
                            
                            let res2  = try? JSONDecoder().decode(T.self, from:response.data!)
                            callback(res2,nil)
                            
                            
                        } else if (data != nil) {
                       
                            let errorRes = try JSONDecoder().decode(PlatformError.self, from:response.data!)
                            callback(nil, errorRes)
                      
                        } else {
                            let pError = PlatformError()
                            pError.message = "Network error"
                            pError.errorCode = res.statusCode
                            callback(nil, pError)
                        }
                    }catch {
                        let pError = PlatformError()
                        pError.message = "Exception while Parsing Json Response"
                        pError.errorCode = res.statusCode
                        callback(nil, pError)
                    }
                    
                    
                    
                } else {
                    let pError = PlatformError()
                    pError.message = "Network error"
                    pError.errorCode = 500
                    callback(nil, pError)
                }
                
        }
    }
    
    //========================
    fileprivate func upload<T:BaseResponseModel>(_ request:Router, storeSign: RequestSignature,handler:@escaping (_ result:T?,_ error:PlatformError?)->()) {

        let urlRequest = try! request.asURLRequest()
        let (mrequest, data) = urlRequestWithComponents((urlRequest.url?.absoluteString)!,
                                                            resultSignature: storeSign)
 

        Alamofire.upload(data, with: mrequest).responseJSON(completionHandler: {
            (response:DataResponse<Any>) in
            
            let data = response.result.value
            
            self.printRequest(urlData: request.getRouterInfo(), data)
            
            if let res = response.response {
                
                do {
                    
                    if (res.statusCode == 200 || res.statusCode == 204) {
                        
                        
                        let res2  = try? JSONDecoder().decode(T.self, from:response.data!)
                        handler(res2,nil)
                        
                    } else if (data != nil) {
                        let errorRes = try JSONDecoder().decode(PlatformError.self, from:response.data!)
                        handler(nil, errorRes)
                        
                    } else {
                        let pError = PlatformError()
                        pError.message = "Network error"
                        pError.errorCode = res.statusCode
                        handler(nil, pError)
                        
                    }
                    
                }catch {
                    let pError = PlatformError()
                    pError.message = "Exception while Parsing Json Response"
                    pError.errorCode = res.statusCode
                    handler(nil, pError)
                }
                
            } else {
                let pError = PlatformError()
                pError.message = "Network error"
                pError.errorCode = 500
                handler(nil, pError)
            }
        })
    }
    //======================================
    
    
    
    // this function creates the required URLRequestConvertible and NSData we need to use Alamofire.upload
    fileprivate func urlRequestWithComponents(_ urlString: String, resultSignature: RequestSignature) -> (URLRequest, Data) {
        
        // create url request to send
        var mutableURLRequest = URLRequest(url: URL(string: urlString)!)
        mutableURLRequest.httpMethod = Method.POST.rawValue
        let boundaryConstant = "myRandomBoundary12345";
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        // create upload data to send
        var uploadData = Data()
        
            let fileName = resultSignature.name!
            let imageFile = UIImageJPEGRepresentation(StoreImage.getSavedImage(name: fileName)!, 0.9)!
            
            AQLog.debug(tag:AQLog.TAG_DATABASE_DATA, text: "fileName: \(fileName) image.count: \(imageFile.count)")
            
            // add image
            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append(imageFile)
            
            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n\(fileName)".data(using: String.Encoding.utf8)!)
          
        
        uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        
        
        // set session
        if let sessionToken = UtilityUserDefaults.sharedInstance().getToken() {
            //_ = "Token \(sessionToken)"
            let sessionData = "Token \(sessionToken)"
            //AQLog.info("\(AQLog.TAG_SESSONDATA) : \(sessionData)")
            mutableURLRequest.setValue(sessionData, forHTTPHeaderField: "Authorization")
        }
        
        return (mutableURLRequest, uploadData)
    }
    

    //====================================
    func loginAPI(request:RequestLogin,onComplition:@escaping (_ result:ResponseLogin?, _ error:PlatformError?) -> ()){
        
        makeRequest(Router.sessionLogin(request: request), callback: onComplition)
    }
    
    func ForgorPasswordAPI(request:RequestForgotPassword,onComplition:@escaping (_ result:ResponseForgotPassword?, _ error:PlatformError?)-> ()){
        
        makeRequest(Router.forgotPassword(request: request), callback: onComplition)
    }
    func BulkAPI(request:RequestGetBulkAPI,onComplition:@escaping (_ result:ResponseBulkRequest?, _ error:PlatformError?)-> ()){
        makeRequest(Router.bulkGet(), callback: onComplition)
        
    }
    
    func getAllInventory(request:RequestGetAllInventory,onComplition:@escaping (_ result:ResponseGetAllInvetory?, _ error:PlatformError?)-> ()){
        makeRequest(Router.getAllInvontry(), callback: onComplition)
        
    }
    
    func getAllVendor(request:RequestGetAllVendor,onComplition:@escaping (_ result:ResponseGetAllVendor?, _ error:PlatformError?)-> ()){
        makeRequest(Router.getAllVendor(request: request), callback: onComplition)
        
    }
    
    func getCompanyContactList(request:RequestGetCompanyContact,onComplition:@escaping (_ result:ResponseGetCompanyContact?, _ error:PlatformError?)-> ()){
        makeRequest(Router.getCompanyContactList(request: request), callback: onComplition)
        
    }
    
    func getAllBtachesByProdId(request:RequestGetallBatches,onComplition:@escaping (_ result:ResponseGetAllBatches?, _ error:PlatformError?)-> ()){
        makeRequest(Router.getAllBatchesByProdId(request: request), callback: onComplition)
        
    }
    
    
    func GetProductById(request:RequestProdutById,onComplition:@escaping (_ result:ResponseProduct?, _ error:PlatformError?)-> ()){
        makeRequest(Router.getProductById(request: request), callback: onComplition)
        
    }
    
    func BulkPostAPI(request:RequestPostModel,onComplition:@escaping (_ result:ResponseBulkRequest?, _ error:PlatformError?)-> ()){
        makeRequest(Router.bulkPost(request: request), callback: onComplition)
    }
    
    func SwitchShopPostAPI(request:RequestSwitchShop,onComplition:@escaping (_ result:ResponseSwitchShop?, _ error:PlatformError?)-> ()){
        makeRequest(Router.SwitchShopPost(request: request), callback: onComplition)
    }
    
    func uploadSignature(request: RequestSignature,onComplition:@escaping (_ result:ResponseAsset?, _ error:PlatformError?)-> ()){
        upload(Router.uploadSignature(request: request), storeSign: request, handler: onComplition)
    }
    
    func updateTransferDetailStatus(request: RequestUpdateTransferStatus,onComplition:@escaping (_ result:ResponseUpdateTransferStatus?, _ error:PlatformError?)-> ()){
        makeRequest(Router.updateTransferStatusById(request: request), callback: onComplition)
    }
    
    func prepareInvoice(request: RequestCreateInvoice,onComplition:@escaping (_ result:ResponseCreateInvoice?, _ error:PlatformError?)-> ()) {
        makeRequest(Router.prepareInvoice(request: request), callback: onComplition)
    }
    
    func createInvoice(request: RequestCreateInvoice,onComplition:@escaping (_ result:ResponseCreateInvoice?, _ error:PlatformError?)-> ()) {
        makeRequest(Router.createInvoice(request: request), callback: onComplition)
    }
    
    func getProductByBatchSku(request : RequestProductByBatchSku,onComplition:@escaping(_ result:ResponseProductByBatchSku?, _ error:PlatformError?)->()){
         makeRequest(Router.getProductByBatchSKU(request: request), callback: onComplition)
    }
    
    private func printRequest(urlData: (Method, String, Data?, [String:Any]?)?,_ data: Any?){
 
        guard UtilPrintLogs.canPrintResponseLog else {
            return
        }
        var str: String = ""
        str.append("\n\n\n\n")
        str.append("=================================================================")
        let URL = Foundation.URL(string: Router.baseURLString)!
        let request = URLRequest(url: URL.appendingPathComponent(urlData!.1))
        
        
        str.append("\n")
        str.append("--------------------------REQUEST--------------------------")
        str.append("\n")
        str.append("\(urlData?.0.rawValue) -- ")
        str.append("\(request.urlRequest!)")
        str.append("\n")
 
        
        if let body = urlData?.2 {
            //Convert back to string.
            if let jsonRequest = String(data: body, encoding: String.Encoding.utf8) {
                str.append("\(jsonRequest)")
            }else{
                str.append("NonJson Request")
            }
        }
        
        
        //=========== RESPONSE
        str.append("\n\n")
        str.append("--------------------------RESPONSE--------------------------")
        str.append("\n")
        
        if let data = data {
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                //Convert back to string.
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    
                    
                    str.append("\(JSONString)")
                    
                }else{
                    
                    str.append("Error in Json")
                    
                }
            }catch {
                UtilPrintLogs.responseLogs(message:DLogMessage.Request.rawValue , objectToPrint: error.localizedDescription)
            }
        }else {
            str.append("NonJson Response")
        }
        
        str.append("\n")
        str.append("----------------------------------------------------")
        str.append("\n")
        str.append("----------------------------------------------------")
        //print(str)
        UtilPrintLogs.responseLogs(message: DLogMessage.Request.rawValue, objectToPrint: str)

    }
}
    

