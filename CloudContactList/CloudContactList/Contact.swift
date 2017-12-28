//
//  Contact.swift
//  CloudContactList
//
//  Created by Madushani Lekam Wasam Liyanage on 12/6/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

enum ContactsModelParseError: Error {
    case results(json: Any)
}

class Contact {
    
    let name: String
    let company: String
    let role: String
    let email: String
    let avatarUrl: String
    
    init(name: String, company: String, role: String, email: String, avatarUrl: String) {
        
        self.name = name
        self.company = company
        self.role = role
        self.email = email
        self.avatarUrl = avatarUrl
    }
    
    convenience init?(from dictionary: [String:AnyObject]) throws {
        
        var avatarUrl = " "
        
        if let name = dictionary["name"] as? String,
            let company = dictionary["company"] as? String,
            let role = dictionary["role"] as? String,
            let email = dictionary["email"] as? String,
            let avatarString = dictionary["avatarurl"] as? String {
            
            avatarUrl = avatarString
            self.init(name: name, company: company, role: role, email: email, avatarUrl: avatarUrl)
        }
            
        else {
            return nil
        }
        
    }
    
    static func getContacts(from data: Data) -> [Contact]? {
        var contactsToReturn: [Contact]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [[String:AnyObject]] = jsonData as? [[String:AnyObject]]
                
                else {
                    throw ContactsModelParseError.results(json: jsonData)
            }
            
            for contactDict in response {
                
                if let contact = try Contact(from: contactDict) {
                    contactsToReturn?.append(contact)
                }
                
            }
            
        }
            
        catch let ContactsModelParseError.results(json: json)  {
            print("Error encountered with parsing contacts for object: \(json)")
        }
            
        catch {
            print("Unknown parsing error")
        }
        
        return contactsToReturn
    }
    
}
