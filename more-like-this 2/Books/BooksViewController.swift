//
//  ViewController.swift
//  moreLikeThis
//
//  Created by Miguel Gomez on 11/5/23.
//

import UIKit

protocol BooksViewControllerDelegate: AnyObject {
    func fetchBooksForListNameEncoded(_ listNameEncoded: String)
}

class BooksViewController: UIViewController, UITableViewDataSource, BooksViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var bookDisplayItems: [BookDisplayItem] = []
    var lists: [List] = []
    var currentListNameEncoded: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBooksForOverview()
        tableView.dataSource = self
    }

    func fetchBooksForOverview() {
        let nytimesAPIURL = URL(string: "https://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=YPectrsOlBimkWlAFs2Mq3ulolb0SjgK")!
        fetchData(from: nytimesAPIURL)
    }

    func fetchBooksForListNameEncoded(_ listNameEncoded: String) {
        currentListNameEncoded = listNameEncoded
        let urlString = "https://api.nytimes.com/svc/books/v3/lists/current/\(listNameEncoded).json?api-key=YPectrsOlBimkWlAFs2Mq3ulolb0SjgK"

        guard let url = URL(string: urlString) else {
                print("Invalid URL: \(urlString)")
                return
            }
            print("Fetching books for URL: \(url)")
            fetchData(from: url)
    }

    func fetchData(from url: URL) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                DispatchQueue.main.async {
                    print("❌ Network error: \(error.localizedDescription)")
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    print("❌ Data is nil")
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(BooksResponse.self, from: data)
                DispatchQueue.main.async {
                    // If it's the overview endpoint, get the list_name_encoded from the list
                    if let lists = response.results.lists {
                        self.lists = lists
                        self.bookDisplayItems = lists.flatMap { list in
                            list.books.map { BookDisplayItem(book: $0, listNameEncoded: list.list_name_encoded) }
                        }
                    }

                    else if let books = response.results.books, let listNameEncoded = self.currentListNameEncoded {
                        self.bookDisplayItems = books.map { BookDisplayItem(book: $0, listNameEncoded: listNameEncoded) }
                    }
                    self.tableView.reloadData()
                }
                
            } catch {
                DispatchQueue.main.async {
                    print("❌ Error parsing JSON: \(error)")
                    print("❌ Received data: \(String(decoding: data, as: UTF8.self))")
                }
            }
        }
        task.resume()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookDisplayItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        let bookDisplayItem = bookDisplayItems[indexPath.row]
        cell.configure(with: bookDisplayItem.book)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let booksDetailController = segue.destination as? BooksDetailController {
            let bookDisplayItem = bookDisplayItems[indexPath.row]
            booksDetailController.book = bookDisplayItem.book
            booksDetailController.listNameEncoded = bookDisplayItem.listNameEncoded
            booksDetailController.delegate = self
        }
    }

}
