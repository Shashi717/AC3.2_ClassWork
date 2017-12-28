//
//  SectionedTableViewController.swift
//  TrivialTableWithSections
//
//  Created by Madushani Lekam Wasam Liyanage on 11/23/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class SectionedTableViewController: UITableViewController {

    var dataArray = [Int]()
    let numOfSections = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<20 {
            dataArray.append(i)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //section is 0 or 1, mod by 2 == 0 or, 1
       // return self.dataArray.filter{$0 % numOfSections == section}.count

//        switch section {
//        case 0:
//            return dataArray.count/2
//        case 1:
//            return dataArray.count - dataArray.count/2
//        default:
//            return 0
//        }
        
        var sectionData = [Int]()
        if section == 0{
        sectionData = self.dataArray.filter { (n:Int) -> Bool in
            if n < self.dataArray.count / numOfSections {
                return true
            }
            return false
        }
        }
        else if section == 1 {
            sectionData = self.dataArray.filter { (n:Int) -> Bool in
                if n >= self.dataArray.count / numOfSections {
                    return true
                }
                return false
            }
        }
        return sectionData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

//        var sectionData = [Int]()
//        switch indexPath.row {
//        case 0:
//            sectionData = self.dataArray.filter{$0 <= 10}
//        case 1:
//            sectionData = self.dataArray.filter{$0 > 10}
//        default:
//            sectionData = []
//        }

        
        var sectionData = [Int]()
        if indexPath.section == 0{
            sectionData = self.dataArray.filter { (n:Int) -> Bool in
                if n < self.dataArray.count / numOfSections {
                    return true
                }
                return false
            }
        }
        else if indexPath.section == 1 {
            sectionData = self.dataArray.filter { (n:Int) -> Bool in
                if n >= self.dataArray.count / numOfSections {
                    return true
                }
                return false
            }
        }

        
//        let sectionData = self.dataArray.filter{$0 < 10}
//       // cell.textLabel?.text = String(self.dataArray[indexPath.row])
       cell.textLabel?.text = String(sectionData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let n = 0
//        switch section {
//        case n:
//            return "Even"
//        case n+1:
//            return "Odd"
//        default:
//            return "Whaa?"
//        }
        
//        for i in 0..<numOfSections {
//            if section == i {
//            return String(i)
//            }
//        }
//        if section == 0 {
//            return "Divisible by \(numOfSections)"
//        }
//        return "Remainder: \(section)"
        
        return String(section)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
