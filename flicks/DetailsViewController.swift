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
    
    @IBOutlet weak var detailsMoviePoster: UIImageView!
    @IBOutlet weak var detailsMovieOverview: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailsMoviePoster.setImageWith(NSURL(string: moviePosterUrl as String) as! URL)
        
        detailsMovieOverview.text = movieOverview as String?

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
