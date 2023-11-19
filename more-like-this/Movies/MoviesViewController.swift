//
//  MoviesViewController.swift
//  moreLikeThis
//
//  Created by Julio Padron on 11/11/23.
//

import UIKit

enum MovieListType {
    case nowPlaying
    case similar(movieId: Int)
}

class MoviesViewController: UIViewController, UITableViewDataSource {

    var movies: [Movies] = []
    var movieListType: MovieListType = .nowPlaying
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchMovies()
    }

    private func fetchMovies() {
        var urlString: String
        switch movieListType {
        case .nowPlaying:
            urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=952c9532a6a4fb8be67768c55adbca02"
        case .similar(let movieId):
            urlString = "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=952c9532a6a4fb8be67768c55adbca02"
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
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.movies = response.results
                    print("Fetched movies: \(self?.movies.count ?? 0)")
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let detailViewController = segue.destination as? MoviesDetailViewController {
            let movie = movies[indexPath.row]
            detailViewController.movies = movie
        }
    }
    @IBAction func onLogOutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {

            // Deselect the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
