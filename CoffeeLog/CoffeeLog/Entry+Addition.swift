//
//  Entry+Addition.swift
//  CoffeeLog
//
//  Created by Madushani Lekam Wasam Liyanage on 12/21/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

extension Entry {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        date = NSDate()
    }

    var localizedDescription: String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        let string = formatter.string(from: date! as Date)
        
        return "☕️ \(string)"
    }
    
    public override func prepareForDeletion() {
        super.prepareForDeletion()
        print("Deleting object")
    }
}
