//
//  DetailsViewController.swift
//  flicks
//
//  Created by Usman Ajmal on 10/14/16.
//  Copyright © 2016 worotos. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var moviePosterUrl: NSString! = nil
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
        
        detailsMoviePoster.setImageWith(NSURL(string: moviePosterUrl as String) as! URL)
        
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
