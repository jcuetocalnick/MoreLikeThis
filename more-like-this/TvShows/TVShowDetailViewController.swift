//
//  TVShowDetailViewController.swift
//  moreLikeThis
//
//  Created by Jane Calnick on 11/12/23.
//

import Nuke
import UIKit

class TVShowDetailViewController: UIViewController {
    
    
    @IBOutlet weak var TVShowImage: UIImageView!
    
    @IBOutlet weak var TVShowTitle: UILabel!
    
    @IBOutlet weak var VoteAverage: UILabel!
    
    @IBOutlet weak var popularity: UILabel!
    
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var overview: UILabel!
    var tvShow: TvShow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //         Do any additional setup after loading the view.
        //         Load the image located at the `artworkUrl100` URL and set it on the image view.
        Nuke.loadImage(with: tvShow.posterImageURL, into: TVShowImage)
        if let image = tvShow.posterImageURL{
            Nuke.loadImage(with: image, into: TVShowImage)
        }
        
        // Set labels with the associated track values.
        TVShowTitle.text = tvShow.name
        VoteAverage.text = String(tvShow.vote_average)
        popularity.text = String(tvShow.popularity)
        votes.text = String(tvShow.vote_count)
        overview.text = tvShow.overview
        
    }
}
