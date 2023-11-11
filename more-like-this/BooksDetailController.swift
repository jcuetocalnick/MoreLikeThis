//
//  BooksDetailController.swift
//  BookTest
//
//  Created by Miguel Gomez on 11/9/23.
//

import Foundation
import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var rlwLabel: UILabel!
    
    @IBOutlet weak var wolLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var book: Book!
    var movie: Movies!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Nuke.loadImage(with: book.book_image, into: coverImageView)
        titleLabel.text = book.title
        authorLabel.text = book.author
        rankLabel.text = String(book.rank)
        rlwLabel.text = String(book.rank_last_week)
        wolLabel.text = String(book.weeks_on_list)
        descriptionLabel.text = book.description
    }
}
