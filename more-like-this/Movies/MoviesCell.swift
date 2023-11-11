//
//  MoviesCell.swift
//  moreLikeThis
//
//  Created by Julio Padron on 11/11/23.
//

import UIKit
import Nuke


class MoviesCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var moviesImageView: UIImageView!
    
    @IBOutlet weak var MovieTitle: UILabel!
    
    @IBOutlet weak var MovieOverview: UILabel!
    
    /// Configures the cell's UI for the given track.
    func configure(with movies: Movies) {
        MovieTitle.text = movies.title
        MovieOverview.text = movies.overview

        // Load image async via Nuke library image loading helper method
        if let image = movies.posterImageURL{
            Nuke.loadImage(with: image, into: moviesImageView)
        }
    }
}
