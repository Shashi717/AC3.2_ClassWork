//
//  Critics.swift
//  NYTMovieReviews
//
//  Created by Madushani Lekam Wasam Liyanage on 11/2/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation


enum CriticsModelParseError: Error {
    case results(json: Any)
    case image(image: Any)
}

class Critics {
    
    let name: String
    let image: String
    
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    convenience init?(from dictionary: [String:AnyObject]) throws {
        var imageString = ""
        
        guard let name = dictionary["display_name"] as? String else { return nil }
        if let multimedia = dictionary["multimedia"] as? [String:AnyObject],
            let images = multimedia["resource"] as? [String:AnyObject] {
            imageString = images["src"] as! String
        }
        
        self.init(name: name, image: imageString)
    }
    //            else {
    //                return nil
    //            }
    
    static func getCritics(from data: Data) -> [Critics]? {
        var criticsToReturn: [Critics]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
                let critics: [[String : AnyObject]] = response["results"] as? [[String:AnyObject]] else {
                    throw CriticsModelParseError.results(json: jsonData)
            }
            
            for criticDict in critics {
                if let critic = try Critics(from: criticDict) {
                    criticsToReturn?.append(critic)
                }
            }
        }
        catch let CriticsModelParseError.results(json: json)  {
            print("Error encountered with parsing 'results' key for object: \(json)")
        }
        catch let CriticsModelParseError.image(image: im)  {
            print("Error encountered with parsing 'image': \(im)")
        }
        catch {
            print("Unknown parsing error")
        }
        
        return criticsToReturn
    }
}
