//
//  GiphyFactory.swift
//  Giphy
//
//  Created by Madushani Lekam Wasam Liyanage on 10/26/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class GiphyFactory {
    
    static let manager: GiphyFactory = GiphyFactory()
    private init() {}
    
    class func makeGiphys(apiEndpoint: String, callback: @escaping ([Giphy]?) -> Void) {
        
        if let validGiphyEndpoint: URL = URL(string: apiEndpoint) {
            
            // 1. URLSession/Configuration
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // 2. dataTaskWithURL
            session.dataTask(with: validGiphyEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
                
                // 3. check for errors right away
                if error != nil {
                    print("Error encountered!: \(error!)")
                }
                
                // 4. printing out the data
                if let validData: Data = data {
                    print(validData) // not of much use other than to tell us that data does exist
                    
                    if let allTheGiphys: [Giphy] = GiphyFactory.manager.getGiphys(from: validData) {
                        //to update the UI with data when view loads (otherwise you'll have to manually scroll to get the data
                        print(allTheGiphys)
                        callback(allTheGiphys)
                        
                    }
                }
                
                }.resume()
            
        }
        
        
    }
    

    internal func getGiphys(from jsonData: Data) -> [Giphy]? {
        
        do {
            let giphyJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            // Cast from Any and check for the "cats" key
            guard let giphyJSONCasted: [String : AnyObject] = giphyJSONData as? [String : AnyObject],
                let giphyArray: [AnyObject] = giphyJSONCasted["data"] as? [AnyObject] else {
                    return nil
            }
            
            var giphys: [Giphy] = []
            
            giphyArray.forEach({ giphyObject in
                guard let giphySlug: String = giphyObject["slug"] as? String,
                    let giphySourceString: String = giphyObject["source_tld"] as? String,
                    let animatedGiphyURLString: String = giphyObject["url"] as? String,
                    let giphyImageDict: [String:Any] = giphyObject["images"] as? [String:Any],
                    
                    // Some of these values need further casting
                    let stillImageDict: [String:String] = giphyImageDict["fixed_height_still"] as? [String:String],
                    let stillImageString: String = stillImageDict["url"]
                    
                    else { return }
                
                giphys.append(Giphy(slug: giphySlug, giphyURLString: animatedGiphyURLString, giphyStillImageString: stillImageString, source: giphySourceString))
            })
            return giphys
        }
        catch let error as NSError {
            print("Error occurred while parsing data: \(error.localizedDescription)")
        }
        
        return  nil
    }
    
    
    
    
}
