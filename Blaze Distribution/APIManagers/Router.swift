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
    //Invoice
    case sessionInvoice(request: [String:String])
    
    
    
    
    
    //===========================================================================================
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let (method, path, requestJson, params): (Method, String, Data?, [String:Any]?) = getRouterInfo()
        
        let URL = Foundation.URL(string: Router.baseURLString)!
        var request = URLRequest(url: URL.appendingPathComponent(path))
        request.httpMethod = method.rawValue 
        if let requestJson = requestJson {
            do {
                let jsonData = requestJson
                
                //Convert back to string.
                if let jsonRequest = String(data: jsonData, encoding: String.Encoding.utf8) {
                    
                 
                }else{
                    AQLog.debug(tag: AQLog.TAG_REQUEST_DATA, text: "NonJson Request: \(jsonData)")
                }
                
                request.httpBody = jsonData
                
            } catch let error as NSError {
                print(error)
            }

        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let sessionToken = UserDefaults.standard.object(forKey: "ACCESS_TOKEN") as! String? {
            let sessionData = "Token \(sessionToken)"
            request.setValue(sessionData, forHTTPHeaderField: "Authorization")
        }
        
        return try Alamofire.URLEncoding.default.encode(request, with: params)
    }
    
    
    func getRouterInfo () -> (Method,String,Data?,[String:Any]?) {
        
        switch(self) {
            
        // SESSIONS
        case .sessionLogin(let request):
                    return (Method.POST,"/api/v1/session/terminal/init",encode(request),nil)
        case .sessionInvoice(let request):
            return (Method.GET,"/api/v1/warehouse/mgmt/invoice",nil,request)
        }
       
    }
    private func encode <T: BaseRequest>(_ requestObj: T) -> Data?{
        return try? JSONEncoder().encode(requestObj)
    }
}
