//
//  TvShowsViewController.swift
//  moreLikeThis
//
//  Created by Janet Cueto Calnick on 11/12/23.
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
}

