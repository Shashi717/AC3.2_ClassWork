//
//  Student.swift
//  C4QStudentBook
//
//  Created by Madushani Lekam Wasam Liyanage on 9/30/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class Student {
    
    let id: Int
    let github: String
    let linkedin: String
    let funFact: String
    let info: Bio
    
//    "info": [
//    "fullName": "Jason Wang",
//    "email":"qwang216@gmail.com",
//    "imageName": "jason",
//    ],
//    "studentID": 3200,
//    "github": "qwang216",
//    "linkedin": "jasonqwang",
//    "funFact": "I code for food"
//    ]
    
    init(studentDict: [String:Any]) {
        
        if let fact = studentDict["funFact"] as? String, let studentID = studentDict["studentID"] as? Int, let githubAcc = studentDict["github"] as? String, let linkedinAcc = studentDict["linkedin"] as? String, let studentInfo = studentDict["info"] as? [String:Any] {
            
            self.funFact = fact
            self.id = studentID
            self.github = githubAcc
            self.linkedin = linkedinAcc
            self.info = Bio(bioDict: studentInfo)

        }
        else {
            self.funFact = "N/A"
            self.id = 0
            self.github = "N/A"
            self.linkedin = "N/A"
            self.info = Bio(bioDict: ["" : ""])
        }
    }
    
}
