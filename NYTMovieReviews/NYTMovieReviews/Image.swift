//
//  Image.swift
//  NYTMovieReviews
//
//  Created by Madushani Lekam Wasam Liyanage on 11/2/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class Image {
    let height: Int
    let width: Int
    let url: URL
    
    init?(from dictionary: [String:AnyObject]) {
        if let height = dictionary["height"] as? Int,
            let width = dictionary["width"] as? Int,
            let url = dictionary["src"] as? String,
            let validURL = URL(string: url) {
            self.height = height
            self.width = width
            self.url = validURL
        }
        else {
            return nil
        }
    }
}
