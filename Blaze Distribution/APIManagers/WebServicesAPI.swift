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
    fileprivate func makeRequest<T:BaseResponseModel>(_ request:URLRequestConvertible, callback:@escaping (_ result:T?, _ error:PlatformError?)-> Void ){
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
    
    func loginAPI(request:RequestLogin,onComplition:@escaping (_ result:ModelLogin?, _ error:PlatformError?) -> ()){
        
        makeRequest(Router.sessionLogin(request: request), callback: onComplition)
    }
    
    
//    func getAllInvoicesAPI(request:RequestLogin,onComplition:@escaping (_ result:ModelLogin?, _ error:PlatformError?) -> ()){
//        
//        makeRequest(Router.sessionLogin(request: request), callback: onComplition)
//    }
    
    
    
    // MARK: -  Login API
//    func login(user_Name:String,password:String,onComplition:@escaping (String)->Void){
//        var data:ModelLogin!
//        let url = "https://api.dev.blaze.me/api/v1/session/terminal/init"
//        print("URL:",url)
//        let header:HTTPHeaders = ["Content-Type":Constants.Development.Content_Type]
//        let parametrs:Parameters = ["email"          :user_Name,
//                                    "password"       :password,
//                                    "version"        :"2.10.10",
//                                    "deviceId"       :"1F036D8E-1EE4-4C1C-B451-0EA44760344F"]
//        print("Parameter",parametrs)
//        Alamofire.request(url, method: .post, parameters: parametrs, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler:{ response in
//            switch response.result{
//            case .success:
//
//                if response.response?.statusCode == 200{
//
//                do{
//                    data = try JSONDecoder().decode(ModelLogin.self, from:response.data!)
//                    let realm = try! Realm()
//                    try! realm.write {
//
//                        realm.add((data)!)
//
//                        onComplition("true")
//
//                    }
//
//
//                }catch{
//                    print(error)
//                }
//
//
//                }else if response.response?.statusCode == 400{
//
//                    print("Bad request ...")
//
//                }else if response.response?.statusCode == 401{
//
//                    print("Unauthorized user ...")
//
//                }else{
//
//                    print("Server error ....")
//
//                }
//
//
//
//                //onComplition(jsonData,"",code!)
//                break
//            case .failure(let error):
//                print(error)
//                //onComplition(JSON.null,error.localizedDescription,0)
//                break
//            }
//        })
//
//    }
//
    private func printRequest(_ requestUrl:URLRequest?,_ data: Any?){
        
        let str = "Request is Nil"
        
        guard data != nil else {
            AQLog.debug(tag: AQLog.TAG_RESPONSE_DATA, text: "URL: \(requestUrl?.description ?? str) \n Response: in Nil")
            return
        }
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string.
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                
                
                AQLog.debug(tag: AQLog.TAG_RESPONSE_DATA, text: "URL: \(requestUrl?.description ?? str) \n Response: \(JSONString)")
                
            }else{
                AQLog.debug(tag: AQLog.TAG_RESPONSE_DATA, text: "NonJson Response: \(jsonData)")
            }
            
        }catch {
            print("In RestWrapper.makeRequest \(error.localizedDescription)")
        }
        
    }


}
    

