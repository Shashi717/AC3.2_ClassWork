//
//  Article+Extension.swift
//  CoreDataArticles
//
//  Created by Madushani Lekam Wasam Liyanage on 11/28/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

extension Article {
    
    func populate(from dict: [String:Any]) {
        if let title = dict["title"] as? String,
            let abstract = dict["abstract"] as? String,
            let section = dict["section"] as? String,
            let byline = dict["byline"] as? String,
            let url = dict["url"] as? String,
            let publishedDateString = dict["published_date"] as? String {

            let formatter = ISO8601DateFormatter()
            let publishedDate = formatter.date(from: publishedDateString)! as NSDate
            
            self.title = title
            self.abstract = abstract
            self.section = section
            self.byline = byline
            self.url = url
            self.publishedDate = publishedDate
            
        }
    }
    
}
