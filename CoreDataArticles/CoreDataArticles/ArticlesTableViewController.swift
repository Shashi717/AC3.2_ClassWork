//
//  ArticlesTableViewController.swift
//  CoreDataArticles
//
//  Created by Madushani Lekam Wasam Liyanage on 11/28/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import CoreData

class ArticlesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchBarDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<Article>!
    
    @IBOutlet var searchBar: UITableView!
    
    var searchTerm: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initializeFetchedResultsController()
        getData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        APIRequestManager.manager.getData(endPoint: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=f41c1b23419a4f55b613d0a243ed3243")  { (data: Data?) in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
                    if let wholeDict = jsonData as? [String:Any],
                        let records = wholeDict["results"] as? [[String:Any]] {
                        
                        // used to be our way of adding a record
                        // self.allArticles.append(contentsOf:Article.parseArticles(from: records))
                        
                        // create the private context on the thread that needs it
                        let moc = (UIApplication.shared.delegate as! AppDelegate).dataController.privateContext
                        
                        
                        
                        moc.performAndWait {
                            for record in records {
                                
                                guard let title = record["title"] as? String else { continue }
                                
                                //                                if let title = record["title"] as? String {
                                let fetchRequest = NSFetchRequest<Article>(entityName: "Article")
                                let predicate =  NSPredicate(format: "title = %@", title)
                                
                                fetchRequest.predicate = predicate
                                if let articleArr = try? fetchRequest.execute() {
                                    // this determines whether something was found
                                    if let article = articleArr.last {
                                        article.populate(from: record)
                                    }
                                    else {
                                        // now it goes in the database
                                        let article = NSEntityDescription.insertNewObject(forEntityName: "Article", into: moc) as! Article
                                        article.populate(from: record)
                                    }
                                }
                            }
                            
                            do {
                                try moc.save()
                                
                                moc.parent?.performAndWait {
                                    do {
                                        try moc.parent?.save()
                                    }
                                    catch {
                                        fatalError("Failure to save context: \(error)")
                                    }
                                }
                            }
                            catch {
                                fatalError("Failure to save context: \(error)")
                            }
                            
                        }
                        // start off with everything
                        //self.articles = self.allArticles
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func initializeFetchedResultsController() {
        let moc = (UIApplication.shared.delegate as! AppDelegate).dataController.managedObjectContext
        
        let request = NSFetchRequest<Article>(entityName: "Article")
        let sectionSort = NSSortDescriptor(key: "section", ascending: true)
        let sort = NSSortDescriptor(key: "publishedDate", ascending: false)
        request.sortDescriptors = [sectionSort, sort]
        
        if let search = self.searchTerm {
            let predicate = NSPredicate(format: "section == %@", search)
            request.predicate = predicate
        }
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "section", cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        guard let sections = fetchedResultsController.sections else {
            print("No sections in fetchedResultsController")
            return 0
        }
        // print(sections.count)
        return sections.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // get count in section
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        
        let sectionInfo = sections[section]
        
        return sectionInfo.numberOfObjects
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        
        configureCell(cell, indexPath: indexPath)
        
        
        return cell
    }
    
    
    func configureCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        
        // get an object
        let article = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = article.title
        // cell.detailTextLabel?.text = article.abstract
        
        let formatter = DateFormatter()
        //formatter.dateStyle = .medium
        //formatter.timeStyle = .none
        // yyyy-MM-dd'T'HH:mm
        //yyyy-MM-dd'T'HH:mm:ss.SSSZ
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.detailTextLabel?.text = formatter.string(from: article.publishedDate as! Date)
        // print(article.publishedDate!)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        
        let sectionInfo = sections[section]
        return sectionInfo.name
    }
    
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            if let ip = indexPath {
                tableView.deleteRows(at: [ip], with: .fade)
            }
        case .update:
            if let ip = indexPath,
                let cell = tableView.cellForRow(at: ip) {
                configureCell(cell, indexPath: ip)
            }
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print("search: " + searchBar.text!)
        if let search = searchBar.text {
            self.searchTerm = search
            initializeFetchedResultsController()
            self.tableView.reloadData()
        }
    }
    
}
