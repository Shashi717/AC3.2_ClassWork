//
//  Reviews.swift
//  NYTMovieReviews
//
//  Created by Madushani Lekam Wasam Liyanage on 11/2/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation


enum ReviewssModelParseError: Error {
    case results(json: Any)
    case image(image: Any)
}

class Reviews {
    
    let criticName: String
    let movieName: String
    let headline: String
    let summary: String
    let movieImage:String
    
    init(criticName: String, movieName: String, headline: String, summary: String, movieImage: String) {
        self.criticName = criticName
        self.movieName = movieName
        self.headline = headline
        self.summary = summary
        self.movieImage = movieImage
    }
    
    convenience init?(from dictionary: [String:AnyObject]) throws {
        var imageString = ""
        
        guard let critic = dictionary["byline"] as? String,
            let movie = dictionary["display_title"] as? String,
            let headline = dictionary["headline"] as? String,
            let shortSummary = dictionary["summary_short"] as? String else {
                return nil
        }
        
        if let multimedia = dictionary["multimedia"] as? [String:AnyObject] {
            imageString = multimedia["src"] as! String
        }
        
        self.init(criticName: critic, movieName: movie, headline: headline, summary: shortSummary,  movieImage: imageString)
    }
    
    
    static func getReviews(from data: Data) -> [Reviews]? {
        
        var reviewsToReturn: [Reviews]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
                let reviews: [[String : AnyObject]] = response["results"] as? [[String:AnyObject]] else {
                    throw CriticsModelParseError.results(json: jsonData)
            }
            
            for reviewDict in reviews {
                if let review = try Reviews(from: reviewDict) {
                    reviewsToReturn?.append(review)
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
        
        return reviewsToReturn
    }
}
