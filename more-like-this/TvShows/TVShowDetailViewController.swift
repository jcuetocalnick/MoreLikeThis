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
    @IBAction func moreLikeThisTapped(_ sender: UIButton) {
        if let tvShowId = tvShow?.id {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let tvShowVC = storyboard.instantiateViewController(withIdentifier: "TvShowsViewController") as? TvShowsViewController {
                    tvShowVC.tvShowListType = .similar(tvShowId: tvShowId)
                    print("Navigating to similar TV shows for ID: \(tvShowId)")
                    navigationController?.pushViewController(tvShowVC, animated: true)
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //         Do any additional setup after loading the view.
        //         Load the image located at the `artworkUrl100` URL and set it on the image view.
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
