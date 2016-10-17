//
//  ViewController.swift
//  flicks
//
//  Created by Usman Ajmal on 10/14/16.
//  Copyright © 2016 worotos. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorView: UIView!
    
    var movies: NSArray? = nil
    var moviesListKind: String! = "now_playing"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100;
        
        
        // Tell controller where to get data from for tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        // Customize Navigation Bar
        self.navigationItem.title = "Flicks"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(named: "flicks"), for: .default)

        }
        
        // Get list of Movies
        getMovies(refreshControl: nil)
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(MoviesViewController.getMovies(refreshControl:)), for: UIControlEvents.valueChanged)
        
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCellIdentifier", for: indexPath) as! PrototypeTableViewCell
        
        // Modifying styling of each cell of table view before moving on
        // Custom Highlight - Show no color when user touch down a cell
        // cell.selectionStyle = .none
        
        //  Custom Selection - Show very light blue when user touch up from a cell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.03)
        cell.selectedBackgroundView = backgroundView
        
        
        // DEBUG
        // cell.textLabel!.text = "Row \(indexPath)"
        // print("Row \(indexPath)")
        
        if let moviesDictionary = movies?[indexPath.row] as? NSDictionary {
            if let title = moviesDictionary.value(forKeyPath: "title") as? NSString {
                cell.movieTitleLabel?.text = title as String
            }
            
            if let overview = moviesDictionary.value(forKeyPath: "overview") as? NSString {
                cell.movieOverviewLabel?.text = overview as String
            }
            
            if var posterPathUrl = moviesDictionary.value(forKeyPath: "poster_path") as? NSString {
                // NSLog("URL: \(urlOfImage)")
                posterPathUrl = "https://image.tmdb.org/t/p/w500\(posterPathUrl)" as NSString
                
                // NSLog("URL: \(posterPathUrl)")
                
                // Fade-in image when loading form network
                // Don't fade-in if loading from cache
                let imageRequest = NSURLRequest(url: NSURL(string: posterPathUrl as String)! as URL)
                cell.movieImageView.setImageWith(
                    imageRequest as URLRequest,
                    placeholderImage: UIImage(named: "image-placeholder"),
                    success: { (imageRequest, imageResponse, image) -> Void in
                        // imageResponse will be nil if the image is cached
                        if imageResponse != nil {
                            // print("Image was NOT cached, fade in image")
                            cell.movieImageView.alpha = 0.0
                            cell.movieImageView.image = image
                            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                                cell.movieImageView.alpha = 1.0
                            })
                        } else {
                            // print("Image was cached so just update the image")
                            cell.movieImageView.image = image
                        }
                    }, failure: { (imageRequest, imageResponse, error) -> Void in
                        print(error)
                })
                
                cell.movieImageView.setImageWith(NSURL(string: posterPathUrl as String) as! URL)
            }
        }
        
        return cell
    }

    /**
     *  Get Movies using The Movie DB's API
     */
    func getMovies(refreshControl: UIRefreshControl?) {
        // Provided API key
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        // Provided URL for the API to use
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(self.moviesListKind!)?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )

        // Show loading animation only if pull-refresh is not in-effect as
        // pull-refresh has its own loading animation
        if ((refreshControl) == nil) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            
            // Uncomment following only to test MBProgressHUD animation show/hide operation
            // sleep(3)
            
            if (error == nil) {
            
                self.networkErrorView.isHidden = true
                
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                        // NSLog("Response: \(responseDictionary)")
                        self.setMovies(movies: (responseDictionary.value(forKeyPath: "results") as? NSArray)!)
                    }
                }
            
                // Hide the loading animation
                MBProgressHUD.hide(for: self.view, animated: false)
                
                self.tableView.alpha = 1
            
                // Stop refreshing if pull-refresh was in-effect
                refreshControl?.endRefreshing()
            
                // Reload Data
                print("Reloading data...")
                self.tableView.reloadData()
            }
            else {
                print("Not connected...")
                self.networkErrorView.isHidden = false
                
                // Hide the loading animation
                MBProgressHUD.hide(for: self.view, animated: false)
                
                self.tableView.alpha = 0.5
                
                // Stop refreshing if pull-refresh was in-effect
                refreshControl?.endRefreshing()
            }
        });
        task.resume()
    }
    
    /**
     *  Set movies property with given array of movies
     */
    func setMovies(movies: NSArray) {
        self.movies = movies
        // NSLog("Posts: \(self.movies)")
    }
    
    /** 
     *  Pass data from a view controller to the details view controller that is being presented
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DetailsViewController
        
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        let indexPost = indexPath?[1]
        
        if let moviesDictionary = movies?[indexPost!] as? NSDictionary {
            if let title = moviesDictionary.value(forKeyPath: "title") as? NSString {
                destinationViewController.movieTitle = title
            }
            
            if let overview = moviesDictionary.value(forKeyPath: "overview") as? NSString {
                destinationViewController.movieOverview = overview
            }
            
            if let moviePosterPath = moviesDictionary.value(forKeyPath: "poster_path") as? NSString {
                // NSLog("URL: \(urlOfImage)")
                //posterPathUrl = "https://image.tmdb.org/t/p/w45\(posterPath)" as NSString
                
                NSLog("URL: \(moviePosterPath)")
                destinationViewController.moviePosterPath = moviePosterPath
                //destinationViewController.moviePosterUrl = posterPathUrl
            }
        }
        
        // NSLog("indexPath: \(indexPath?[1])")
    }
}

