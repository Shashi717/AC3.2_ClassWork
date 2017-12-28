//
//  StudentTableViewCell.swift
//  C4QStudentBook
//
//  Created by Madushani Lekam Wasam Liyanage on 9/30/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 35
        profileImageView.layer.masksToBounds = true
        
        //backgroundColor = .red
    }

    func setData(student: Student) {
        let studentInfo = student.info
        self.profileImageView.image = UIImage(named: studentInfo.imageName)
        self.nameLabel.text = studentInfo.firstName + " " + studentInfo.lastName
        self.emailLabel.text = studentInfo.email
    }

}
