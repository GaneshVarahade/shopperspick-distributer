//
//  DispensaryServerRouter.swift
//  DispensaryCore
//
//  Created by Manh Do on 7/5/15.
//  Copyright (c) 2015 420connect. All rights reserved.
//

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
    //BulkPostAPI
    case bulkPost(request: RequestPostModel)
    //Forgot Password
    case forgotPassword(request: RequestForgotPassword)
    
    
    
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
        
        //===========
        // This block is to print the request
        print("json: \(requestJson)")
        if let body = requestJson {
            do {
                

//                let jsonData = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
                // here "jsonData" is the dictionary encoded in JSON data
                
                //Convert back to string.
                if let jsonRequest = String(data: body, encoding: String.Encoding.utf8) {
                    
                    AQLog.debug(tag: AQLog.TAG_REQUEST_DATA, text: "======================================================= \n Request URL: \(request.urlRequest!) \n Request Body: \n \(jsonRequest)")
                }else{
                    AQLog.debug(tag: AQLog.TAG_REQUEST_DATA, text: "NonJson Request: \(body)")
                }
                
            } catch let error as NSError {
                print(error)
            }
            
        }
        
        //============
        return try Alamofire.URLEncoding.default.encode(request, with: params)
    }
    
    
    func getRouterInfo () -> (Method,String,Data?,[String:Any]?) {
        
        switch(self) {
            
        // SESSIONS
        case .sessionLogin(let request):
            return (Method.POST,"/api/v1/session/terminal/init",encode(request),nil)
        case .bulkGet():
            return (Method.GET,"/api/v1/warehouse/mgmt/dataSync",nil,nil)
        case .bulkPost(let request):
            return (Method.POST,"/api/v1/warehouse/mgmt/dataSync",encode(request),nil)
        case.forgotPassword(let request):
            return (Method.POST,"/api/v1/mgmt/password/reset",encode(request),nil)
        }
       
    }
    func encode <T: BaseRequest>(_ requestObj: T) -> Data?{
        return try? JSONEncoder().encode(requestObj)
    }
}
