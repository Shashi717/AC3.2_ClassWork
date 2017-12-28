//
//  CoffeeLogTableViewController.swift
//  CoffeeLog
//
//  Created by Madushani Lekam Wasam Liyanage on 12/21/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import CoreData

class CoffeeLogTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var controller: NSFetchedResultsController<Entry>!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        
        //        do {
        //            let object = Entry(context: context)
        //            object.date = NSDate()
        //
        //            try! context.save()
        //
        //        }
        //
        
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        //ascending false - newest one on top
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Entry.date), ascending: false)]
        
        controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        try! controller.performFetch()
    }
    
    func addButtonPressed() {
        
        //awakeFromInsert() method in the extension replaces this
        //let object = Entry(context: context)
        //object.date = NSDate()
        
        let _ = Entry(context: context)
        try! context.save()
        
        
        //implementing didChange will replace these
        //        try! controller.performFetch()
        //        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = controller.sections {
            let info = sections[section]
            return info.numberOfObjects
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeCellIdentifier", for: indexPath)
        
        let object = controller.object(at: indexPath)
        cell.textLabel?.text = object.localizedDescription
        return cell
    }
    
    //this will give the delete option on swipe
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //this will actually delete the Entry
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = controller.object(at: indexPath)
            context.delete(object)
            try! context.save()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            tableView.insertRows(at: [newIndexPath!], with: .fade)
//        case .delete:
//            if let ip = indexPath {
//                tableView.deleteRows(at: [ip], with: .fade)
//            }
//        case .update:
//            if let ip = indexPath,
//                let cell = tableView.cellForRow(at: ip) {
//                //configureCell(cell, indexPath: ip)
//                
//            }
//        case .move:
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
//        }
    }
    
    //anytime there's a change this will reload the data
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    
}
