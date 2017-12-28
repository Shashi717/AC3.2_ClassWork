//
//  ViewController.swift
//  NYTMovieReviews
//
//  Created by Madushani Lekam Wasam Liyanage on 11/2/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

//fileprivate let reuseIdentifier = "AlbumCell"
fileprivate let itemsPerRow: CGFloat = 3

class NYTViewController: UIViewController, UITableViewDelegate, UICollectionViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var CriticsTableView: UITableView!
    @IBOutlet weak var ReviewsCollectionView: UICollectionView!
    
    var critics: [Critics] = []
    let CriticCellIdentifier = "CriticCellIdentifier"
    
    let criticAPIEndPoint = "https://api.nytimes.com/svc/movies/v2/critics/all.json?api-key=b54e8d92c64b4623a973f5f38fcd1ad4"
    
    var reviews: [Reviews] = []
    let ReviewCellIdentifier = "ReviewCellIdentifier"
    
    let reviewAPIEndPont = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=b54e8d92c64b4623a973f5f38fcd1ad4"
    
    var selectedCritic: Critics?
    var selectedCriticName = String()
    var selectedMovieArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CriticsTableView.delegate = self
        CriticsTableView.dataSource = self
        
        ReviewsCollectionView.delegate = self
        ReviewsCollectionView.dataSource = self
        
        //print( selectedCritic?.name as Any)
        
        APIRequestManager.manager.getData(endPoint: criticAPIEndPoint) { (data: Data?) in
            if  let validData = data,
                let validCritics = Critics.getCritics(from: validData) {
                self.critics = validCritics
                
                //for critic in self.critics { print(critic.name) }
                DispatchQueue.main.async {
                    self.CriticsTableView?.reloadData()
                }
            }
        }
        
        APIRequestManager.manager.getData(endPoint: reviewAPIEndPont) { (data: Data?) in
            if  let validData = data,
                let validReviews = Reviews.getReviews(from: validData) {
                self.reviews = validReviews
                DispatchQueue.main.async {
                    self.ReviewsCollectionView?.reloadData()
                }
            }
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return critics.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CriticCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = critics[indexPath.row].name
        let imageString = critics[indexPath.row].image
        cell.imageView?.image = nil
        if imageString != "" {
            
            APIRequestManager.manager.getData(endPoint: imageString ) { (data: Data?) in
                if  let validData = data,
                    let validImage = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = validImage
                        cell.setNeedsLayout()
                    }
                }
            }
            
        }
        else {
            cell.imageView?.image = UIImage.init(named: "no_image")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCritic = self.critics[indexPath.row]
        selectedCriticName = self.critics[indexPath.row].name
        selectedMovieArray = []
            for aReview in reviews {
                 // print(aReview.criticName + " " + criticNameSelected)
                if selectedCriticName.uppercased() == aReview.criticName{
                     print(aReview.criticName)
                    selectedMovieArray.append(aReview.movieImage)
                    ReviewsCollectionView.reloadData()
                }
                
            }
        //print(selectedMovieArray)
    }
    
    
    
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedMovieArray.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCellIdentifier, for: indexPath)
       
        print(selectedMovieArray)
        
        if let rcvc = cell as? ReviewsCollectionViewCell {
            rcvc.imageView.image = UIImage(named: "no_image")
            for movieString in selectedMovieArray {
                
                if movieString != "" {
                    
                    APIRequestManager.manager.getData(endPoint: movieString) { (data: Data?) in
                        if  let validData = data,
                            let validImage = UIImage(data: validData) {
                            DispatchQueue.main.async {
                                rcvc.imageView.image = validImage
                                cell.setNeedsLayout()
                            }
                        }
                    }
                }
                    
                else {
                    rcvc.imageView.image = UIImage.init(named: "no_image")
                }
            }
        }
            return cell
            
        }
        
        // MARK: - TextField Delegate
        //        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //            search(textField.text!)
        //            textField.text = nil
        //            textField.resignFirstResponder()
        //            return true
        //        }
        
        // MARK: - Utility
        //    func search(_ term: String) {
        //        self.title = term
        //
        //        APIRequestManager.manager.getData(endPoint: reviewAPIEndPont) { (data: Data?) in
        //            if  let validData = data,
        //                let validReviews = Reviews.getReviews(from: validData) {
        //                self.reviews = validReviews
        //                DispatchQueue.main.async {
        //                    self.ReviewsCollectionView?.reloadData()
        //
        //                }
        //            }
        //        }
        //    }
        //    // MARK: - Navigation
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        //      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //            // Get the new view controller using [segue destinationViewController].
        //            // Pass the selected object to the new view controller.
        //        }
        //
        // MARK: - UICollectionViewDelegateFlowLayout
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            
            return CGSize(width: widthPerItem, height: widthPerItem)
        }
        
        // margin around the whole section
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }
        
        // spacing between rows if vertical / columns if horizontal
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }
        
    
    
}

