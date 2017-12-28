//
//  StudentTableTableViewController.swift
//  C4QStudentBook
//
//  Created by Madushani Lekam Wasam Liyanage on 9/30/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class StudentTableTableViewController: UITableViewController {
    
    var students = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Madushani Lekam Wasam Liyanage"
//        
//        "info": [
//        "fullName": "Jason Wang",
//        "email":"qwang216@gmail.com",
//        "imageName": "jason",
//        ],
//        "studentID": 3200,
//        "github": "qwang216",
//        "linkedin": "jasonqwang",
//        "funFact": "I code for food"
//        ],
        
        for studentDict in ac32_students {
            let student = Student(studentDict: studentDict)
            students.append(student)
        }
    }

 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return students.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTVCID", for: indexPath) as! StudentTableViewCell
        
        cell.nameLabel.text = "Madushani"
        cell.emailLabel.text = "liyanagemadushani21@gmail.com"

        // Configure the cell...
        let student = students[indexPath.row]
        cell.setData(student: student)
        return cell
    }
    

 
   



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
