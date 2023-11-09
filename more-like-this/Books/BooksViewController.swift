//
//  ViewController.swift
//  moreLikeThis
//
//  Created by Miguel Gomez on 11/5/23.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDataSource {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        let book = books[indexPath.row]
        cell.configure(with: book)
        return cell
    }

    var books: [Book] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nytimesAPIURL = URL(string: "https://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=YPectrsOlBimkWlAFs2Mq3ulolb0SjgK")!
        let request = URLRequest(url: nytimesAPIURL)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(BooksResponse.self, from: data)
                let books = response.results.lists.flatMap { $0.books }
                DispatchQueue.main.async {
                    self?.books = books
                    self?.tableView.reloadData()
                }
                print("✅ \(books)")
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }


        }
        task.resume()
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let booksDetailController = segue.destination as? BooksDetailController {
            let book = books[indexPath.row]
            booksDetailController.book = book
        }
    }



    
}
