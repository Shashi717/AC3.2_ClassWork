//
//  GiphyDetailViewController.swift
//  Giphy
//
//  Created by Madushani Lekam Wasam Liyanage on 10/26/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class GiphyDetailViewController: UIViewController {
    
    var giphy: Giphy?
    
    @IBOutlet weak var giphyImage: UIImageView!
    
    @IBOutlet weak var giphyWeb: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = giphy?.slug
       
        let giphyUrlString = giphy?.giphyStillImageString
        let animatedGiphyString = giphy?.giphyURLString
   giphyImage.downloadImage(urlString: giphyUrlString!)
        let url = URL(string: animatedGiphyString!)
      //  giphyWeb.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
