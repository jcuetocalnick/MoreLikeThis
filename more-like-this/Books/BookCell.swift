//
//  BookCell.swift
//  moreLikeThis
//
//  Created by Miguel Gomez on 11/5/23.
//

import UIKit
import Nuke

class BookCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.author

        // Load the book cover image using Nuke
        let coverImageURL = book.book_image
            Nuke.loadImage(with: coverImageURL, into: coverImageView)
        
    }
}

