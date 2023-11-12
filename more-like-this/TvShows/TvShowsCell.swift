//
//  TvShowsCell.swift
//  moreLikeThis
//
//  Created by Jane Calnick on 11/12/23.
//

import Foundation
import UIKit
import Nuke


class TvShowsCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /// Configures the cell's UI for the given track.
    
    @IBOutlet weak var TVShowImage: UIImageView!
    
    @IBOutlet weak var TVShowTitle: UILabel!
    
    @IBOutlet weak var TVShowOverview: UILabel!
    func configure(with tvShow: TvShow) {
        TVShowTitle.text = tvShow.name
        TVShowOverview.text = tvShow.overview

        //   Load image async via Nuke library image loading helper method
        if let image = tvShow.posterImageURL{
            Nuke.loadImage(with: image, into: TVShowImage)
        }
    }
}
