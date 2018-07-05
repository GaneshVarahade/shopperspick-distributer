//
//  WebServicesAPI.swift
//  GreenForceDelivery
//
//  Created by Fidel iOS on 08/02/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

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
    fileprivate func makeRequest<T:BaseResponseModel>(_ request:URLRequestConvertible, callback:@escaping (_ result:T?,_ error:PlatformError?)-> Void ){
        Alamofire.request(request)
            .responseJSON { (response:DataResponse<Any>) in
                let data = response.result.value
                
                if let res = response.response {
                    
                    self.printRequest(request.urlRequest, data)
                    
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
    
//    func InvoiceAPI(request:RequestInvoices,onComplition:@escaping (_ result:ResponseGetAllInvoices?, _ error:PlatformError?)-> ()){
//        
//        makeRequest(Router.sessionInvoice(request: ["shopId":request.shopId]), callback: onComplition)
//    }
    func ForgorPasswordAPI(request:RequestForgotPassword,onComplition:@escaping (_ result:ResponseForgotPassword?, _ error:PlatformError?)-> ()){
        
        makeRequest(Router.forgotPassword(request: request), callback: onComplition)
    }
    func BulkAPI(request:RequestGetBulkAPI,onComplition:@escaping (_ result:ResponseBulkRequest?, _ error:PlatformError?)-> ()){
        makeRequest(Router.bulkGet(), callback: onComplition)
        
    }
    private func printRequest(_ requestUrl:URLRequest?,_ data: Any?){
        
        DispatchQueue.global(qos: .background).async {
            let str = "Request is Nil"
            
            guard data != nil else {
                AQLog.debug(tag: AQLog.TAG_RESPONSE_DATA, text: "URL: \(requestUrl?.description ?? str) \n Response: in Nil")
                return
            }
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                //Convert back to string.
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    
                    print(JSONString)
                    AQLog.debug(tag: AQLog.TAG_REQUEST_DATA, text: "URL: \(requestUrl?.description ?? str)")
                    AQLog.debug(tag: AQLog.TAG_RESPONSE_DATA, text: "URL: \(requestUrl?.description ?? str) \n Response: \(JSONString)")
                    
                }else{
                    AQLog.debug(tag: AQLog.TAG_RESPONSE_DATA, text: "NonJson Response: \(jsonData)")
                }
                
            }catch {
                print("In RestWrapper.makeRequest \(error.localizedDescription)")
            }
        }
    }
}
    

