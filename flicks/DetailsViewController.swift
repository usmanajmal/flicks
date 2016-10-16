//
//  DetailsViewController.swift
//  flicks
//
//  Created by Usman Ajmal on 10/14/16.
//  Copyright © 2016 worotos. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var moviePosterPath: NSString! = nil   // e.g. "/z6BP8yLwck8mN9dtdYKkZ4XGa3D.jpg"
    var movieOverview: NSString! = nil
    var movieTitle: NSString! = nil
    
    
    @IBOutlet weak var detailsMoviePoster: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieInfoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let moviePosterUrlLowResolution  = "https://image.tmdb.org/t/p/w45\(moviePosterPath!)" as NSString
        let moviePosterUrlHighResolution = "https://image.tmdb.org/t/p/original\(moviePosterPath!)" as NSString
        
        // NSLog("URL: \(moviePosterUrlHighResolution)")
        NSLog("URL: \(moviePosterUrlLowResolution)")
        
        //detailsMoviePoster.setImageWith(NSURL(string: moviePosterUrlLowResolution as String) as! URL)
        
        // Load high resoution image later in time
        let imageRequestLowResolution = NSURLRequest(url: NSURL(string: moviePosterUrlLowResolution as String)! as URL)
    
        detailsMoviePoster.setImageWith(
            imageRequestLowResolution as URLRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                if imageResponse != nil {
                    print("LowRes - Image was NOT cached, fade in image")
                    // self.detailsMoviePoster.setImageWith(NSURL(string: moviePosterUrlLowResolution as String) as! URL)
                    
                    
                    self.detailsMoviePoster.alpha = 0.0
                    self.detailsMoviePoster.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.detailsMoviePoster.alpha = 1.0
                    })
                    
                } else {
                    print("LowRes - Image was cached so just update the image")
                    self.detailsMoviePoster.image = image
                }
                
                // Now load high resoultion image
                let imageRequestHighResolution = NSURLRequest(url: NSURL(string: moviePosterUrlHighResolution as String)! as URL)
                self.detailsMoviePoster.setImageWith(
                    imageRequestHighResolution as URLRequest,
                    placeholderImage: nil,
                    success: { (imageRequest, imageResponse, image) -> Void in
                        print("HighRes - Image will now be displayed in the image view")
                        self.detailsMoviePoster.image = image
                    }, failure: { (imageRequest, imageResponse, error) -> Void in
                        print(error)
                })

            }, failure: { (imageRequest, imageResponse, error) -> Void in
                print(error)
        })
        
        movieTitleLabel.text = movieTitle as String?
        
        movieOverviewLabel.text = movieOverview as String?
        movieOverviewLabel.sizeToFit()
        
        // Set scroll view parameters
        // let contentWidth = scrollView.bounds.width
        // let contentHeight = scrollView.bounds.height
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: movieInfoView.frame.origin.y + movieInfoView.frame.size.height)
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
