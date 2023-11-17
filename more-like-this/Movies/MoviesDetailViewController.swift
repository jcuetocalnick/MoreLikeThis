//
//  MoviesDetailViewController.swift
//  moreLikeThis
//
//  Created by Julio Padron on 11/11/23.
//

import Nuke
import UIKit

class MoviesDetailViewController: UIViewController {
    @IBOutlet weak var moviePicture: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var VoteAverage: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var votes: UILabel!
    
    @IBAction func moreLikeThisTapped(_ sender: UIButton) {
        if let movieId = movies?.id {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let moviesVC = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController {
                    moviesVC.movieListType = .similar(movieId: movieId)
                    print("Navigating to similar movies for ID: \(movieId)")
                    navigationController?.pushViewController(moviesVC, animated: true)
                }
            }
    }
    
    var movies: Movies!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Load the image located at the `artworkUrl100` URL and set it on the image view.
        //Nuke.loadImage(with: movies.backdrop_path, into: moviePicture)
        if let image = movies.backdropImageURL{
            Nuke.loadImage(with: image, into: moviePicture)
        }

        // Set labels with the associated track values.
        movieName.text = movies.title
        VoteAverage.text = String(movies.vote_average)
        popularity.text = String(movies.popularity)
        votes.text = String(movies.vote_count)
        overview.text = movies.overview
        
    }
}
