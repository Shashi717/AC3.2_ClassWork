//
//  Bio.swift
//  C4QStudentBook
//
//  Created by Madushani Lekam Wasam Liyanage on 9/30/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//


class Bio {
    
    let firstName: String
    let lastName: String
    let email: String
    let imageName: String
    
    
    init(bioDict: [String: Any]) {
        if let fullName = bioDict["fullName"] as? String, let emailString = bioDict["email"] as? String, let imageNameString = bioDict["imageName"] as? String {
            
            self.email = emailString
            self.imageName = imageNameString
            
            let fullNameArray = fullName.components(separatedBy: " ")
            if let fn = fullNameArray.first {
                self.firstName = fn
            }
            else {
                self.firstName = ""
            }
            if let ln = fullNameArray.last {
                self.lastName = ln
            }
            else {
                self.lastName = ""
            }
            
        }
        else {
            self.firstName = "N/A"
            self.lastName = "N/A"
            self.email = "N/A"
            self.imageName = "c4q_logo"
        }
        
    }
}
