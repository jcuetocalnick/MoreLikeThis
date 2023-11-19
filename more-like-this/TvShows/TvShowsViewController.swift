//
//  TvShowsViewController.swift
//  moreLikeThis
//
//  Created by Jane Calnick on 11/12/23.
//

import Foundation
import UIKit

enum TVShowListType {
    case popular
    case similar(tvShowId: Int)
}

class TvShowsViewController: UIViewController, UITableViewDataSource {
    var tvShows: [TvShow] = []
    var tvShowListType: TVShowListType = .popular

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchTVShows()
    }

    private func fetchTVShows() {
        var urlString: String
        switch tvShowListType {
        case .popular:
            urlString = "https://api.themoviedb.org/3/tv/popular?api_key=952c9532a6a4fb8be67768c55adbca02"
        case .similar(let tvShowId):
            urlString = "https://api.themoviedb.org/3/tv/\(tvShowId)/similar?api_key=952c9532a6a4fb8be67768c55adbca02"
        }
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            print("Raw Data: \(String(data: data, encoding: .utf8) ?? "nil")")
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TvShowResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.tvShows = response.results
                    print("Fetched TV shows: \(self?.tvShows.count ?? 0)")
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TvShowsCell", for: indexPath) as! TvShowsCell
        let tvShow = tvShows[indexPath.row]
        cell.configure(with: tvShow)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let detailViewController = segue.destination as? TVShowDetailViewController {
            let tvShow = tvShows[indexPath.row]
            detailViewController.tvShow = tvShow
        }
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tvShow.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Get a cell with identifier, "TrackCell"
//        // the `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TvShowsCell", for: indexPath) as! TvShowsCell
//        
//        // Get the track that corresponds to the table view row
//        let tvShow = tvShow[indexPath.row]
//        cell.configure(with: tvShow)
//        
//        // return the cell for display in the table view
//        return cell
//    }
//    
//    
//    var tvShow: [TvShow] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        tableView.dataSource = self
//        //movies = Movies.mockMovies
//        // Create a URL for the request
//        // In this case, the custom search URL you created in in part 1
//        let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=952c9532a6a4fb8be67768c55adbca02")!
//        
//        // Use the URL to instantiate a request
//        let request = URLRequest(url: url)
//        
//        // Create a URLSession using a shared instance and call its dataTask method
//        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
//        // When finished, it calls it's completion handler (closure) passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if the request was unsuccessful)
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            
//            // Handle any errors
//            if let error = error {
//                print("❌ Network error: \(error.localizedDescription)")
//            }
//            
//            // Print the HTTP status code
//            if let response = response as? HTTPURLResponse {
//                print("Response code: \(response.statusCode)")
//            }
//            
//            // Make sure we have data
//            guard let data = data else {
//                print("❌ Data is nil")
//                return
//            }
//            
//            print("Raw Data: \(String(data: data, encoding: .utf8) ?? "nil")")
//            
//            
//            // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
//            // We cast the resultant returned object to a dictionary with a `String` key, `Any` value pair.
//            do {
//                // Create a JSON Decoder
//                let decoder = JSONDecoder()
//                
//                // Use the JSON decoder to try and map the data to our custom model.
//                // TrackResponse.self is a reference to the type itself, tells the decoder what to map to.
//                let response = try decoder.decode(TvShowResponse.self, from: data)
//                
//                // Access the array of tracks from the `results` property
//                let tvShow = response.results
//                
//                
//                
//                // Execute UI updates on the main thread when calling from a background callback
//                DispatchQueue.main.async {
//                    
//                    // Set the view controller's tracks property as this is the one the table view references
//                    self?.tvShow = tvShow
//                    
//                    // Make the table view reload now that we have new data
//                    self?.tableView.reloadData()
//                }
//                print("✅ \(tvShow)")
//            } catch {
//                print("❌ Error parsing JSON: \(error.localizedDescription)")
//            }
//        }
//        
//        // Initiate the network request
//        task.resume()
//        print("👋 Below the closure")
//        print(tvShow)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // TODO: Pt 1 - Pass the selected track to the detail view controller
//        if let cell = sender as? UITableViewCell,
//           // Get the index path of the cell from the table view
//           let indexPath = tableView.indexPath(for: cell),
//           // Get the detail view controller
//           let detailViewController = segue.destination as? TVShowDetailViewController {
//
//            // Use the index path to get the associated track
//            let tvShow = tvShow[indexPath.row]
//            
//            // Set the track on the detail view controller
//            detailViewController.tvShow = tvShow        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Get the index path for the current selected table view row (if exists)
//        if let indexPath = tableView.indexPathForSelectedRow {
//            
//            // Deselect the row at the corresponding index path
//            tableView.deselectRow(at: indexPath, animated: true)}
//    }
}

