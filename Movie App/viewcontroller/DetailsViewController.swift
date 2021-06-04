//
//  DetailsViewController.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 03/06/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var movie:Movie?

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var uiRoundedContinar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = self.movie{
            self.movieTitle.text = movie.original_title
            self.movieDescription.text = movie.overview
            
            movieImageView.load(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.poster_path)")!)
            
            uiRoundedContinar.dropShadow()
            uiRoundedContinar.layer.cornerRadius = 8
            uiRoundedContinar.layer.shadowRadius = 4
        
            
        }
        
    }
    

}
