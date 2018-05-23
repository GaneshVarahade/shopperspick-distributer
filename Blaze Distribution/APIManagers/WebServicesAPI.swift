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
class WebServicesAPI: NSObject {
    
    static let singleToneObject = WebServicesAPI()
    private override init(){
    }
    // MARK: -  Login API
    func login(user_Name:String,password:String,onComplition:@escaping (String)->Void){
        let url = "https://api.dev.blaze.me/api/v1/session/terminal/init"
        print("URL:",url)
        let header:HTTPHeaders = ["Content-Type":Constants.Development.Content_Type]
        let parametrs:Parameters = ["email"          :user_Name,
                                    "password"       :password,
                                    "version"        :"2.10.10",
                                    "deviceId"       :"1F036D8E-1EE4-4C1C-B451-0EA44760344F"]
        print("Parameter",parametrs)
        
        Alamofire.request(url, method: .post, parameters: parametrs, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler:{ response in
            print("Header:",header)
            
//            let temp = LoginJson(accessToken: "fdgjkdfghk", assetAccessToken: "fghjfdfhjg", employee: nil, loginTime: 12, expirationTime: 12, sessionId: "hjkj", company: nil, shops: nil, assignedShop: nil, newDevice: true, assignedTerminal: nil, appType: "dsfg", appTarget: "ghhh")
            switch response.result{
            case .success:
               
                
                let jsonEncoder = JSONEncoder()
                
                
                do{
                    
//                    let jsonData = try jsonEncoder.encode(temp)
//                    let jsonString = String(data: jsonData, encoding: .utf8)
                    //print(jsonString!)
                }catch{
                    
                    print(error.localizedDescription)
                }
                
              
                
          
                var data :LoginJson!
                if let result = response.data{
                
                    let jsonString = String(data: result, encoding: .utf8)
                   // print(jsonString!)
                do{

                    data = try JSONDecoder().decode(LoginJson.self, from: result)
                }catch{

                    print(error.localizedDescription)
                }
                }
                    print(data)
                //onComplition(jsonData,"",code!)
                break
            case .failure(let error):
                print(error)
                //onComplition(JSON.null,error.localizedDescription,0)
                break
            }
        })

    }
}


struct LoginJson:Codable{
    
    let accessToken : String?
    let assetAccessToken : String?
   
    let loginTime : String?
    let expirationTime : String?
    let sessionId : String?
    
    
    
    let newDevice : String?
   
    let appType : String?
    let appTarget : String?
    
   
    
}
