//
//  ViewController.swift
//  flicks
//
//  Created by Usman Ajmal on 10/14/16.
//  Copyright © 2016 worotos. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: NSArray? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Tell controller where to get data from for tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        // Get list of Movies
        getMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCellIdentifier", for: indexPath)
        
        cell.textLabel!.text = "Row \(indexPath)"
        print("Row \(indexPath)")
        
        return cell
    }

    /**
     *  Get Movies using The Movie DB's API
     */
    func getMovies() {
        // Provided API key
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        // Provided URL for the API to use
        let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    // NSLog("Response: \(responseDictionary)")
                    self.setMovies(movies: (responseDictionary.value(forKeyPath: "results") as? NSArray)!)
                }
            }
            
            print("Reloading data...")
            // Reload Data
            self.tableView.reloadData()
        });
        task.resume()
    }
    
    /**
     *  Set movies property with given array of movies
     */
    func setMovies(movies: NSArray) {
        self.movies = movies
        NSLog("Posts: \(self.movies)")
    }

}

