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
    fileprivate func makeRequest<T:BaseResponseModel>(_ request:Router, callback:@escaping (_ result:T?,_ error:PlatformError?)-> Void ){
        
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
    
    func loginAPI(request:RequestLogin,onComplition:@escaping (_ result:ResponseLogin?, _ error:PlatformError?) -> ()){
        
        makeRequest(Router.sessionLogin(request: request), callback: onComplition)
    }
    
    func ForgorPasswordAPI(request:RequestForgotPassword,onComplition:@escaping (_ result:ResponseForgotPassword?, _ error:PlatformError?)-> ()){
        
        makeRequest(Router.forgotPassword(request: request), callback: onComplition)
    }
    func BulkAPI(request:RequestGetBulkAPI,onComplition:@escaping (_ result:ResponseBulkRequest?, _ error:PlatformError?)-> ()){
        makeRequest(Router.bulkGet(), callback: onComplition)
        
    }
    
    func BulkPostAPI(request:RequestPostModel,onComplition:@escaping (_ result:ResponseBulkRequest?, _ error:PlatformError?)-> ()){
        makeRequest(Router.bulkPost(request: request), callback: onComplition)
        
    }
    
    private func printRequest(urlData: (Method, String, Data?, [String:Any]?)?,_ data: Any?){
 
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
                print("In RestWrapper.makeRequest \(error.localizedDescription)")
            }
        }else {
            str.append("NonJson Response")
        }
        
        str.append("\n")
        str.append("----------------------------------------------------")
        str.append("\n")
        str.append("----------------------------------------------------")
        print(str)

    }
}
    

