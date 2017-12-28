//
//  APIRequestManager.swift
//  NASAAPOD
//
//  Created by Madushani Lekam Wasam Liyanage on 11/5/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callBack: @escaping (Data?) -> Void) {
        
        guard let myURL = URL(string: endPoint) else {return}
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL){(data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error durring session: \(error)")
            }
            
            guard let validData = data else {return}
            
            callBack(validData)
            
            }.resume()
    }
    
    let headers = [
        "accept": "application/json",
        "content-type": "application/json",
        "authorization": "Basic a2V5LTQ6UVpiUDBIYjh2VXpBQ08zVjFzTUg=",
        "cache-control": "no-cache"
    ]
    
    func getAllPosts(from endPoint: String, callBack: @escaping (Data?) -> Void){
        
        var request = URLRequest(url: URL(string: endPoint)!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        // create a new session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // this is slightly different: we use dataTask(with: URLRequest) instead of dataTask(with: URL)
        session.dataTask(with: request) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            
            if error != nil {
                print(error!)
            }
            
            if urlResponse != nil {
                print("Response: \(urlResponse!)")
            }
            
            
            guard let validData = data else {return}
            // print(validData)
            callBack(validData)
            
            }.resume()
    }
    
    
    func postRequest(from endPoint: String, studentDict parameters: [String:Any]) {
        
        //  let postData = JSONSerialization.dataWithJSONObject(parameters, options: nil, error: nil)
        
        var request = URLRequest(url: URL(string: endPoint)!,cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = postData
            
        }
        catch {
            print("Error \(error)")
        }
        
        //create a new session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // this is slightly different: we use dataTask(with: URLRequest) instead of dataTask(with: URL)
        session.dataTask(with: request) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            
            if error != nil {
                print(error!)
            }
            
            if urlResponse != nil {
                print("Response: \(urlResponse!)")
            }
            
            
            if data != nil {
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    
                    if let validJson = jsonData {
                        print(validJson)
                    }
                    
                } catch {
                    print("error response \(error)")
                }
            }
            
            }.resume()
    }
    
}
