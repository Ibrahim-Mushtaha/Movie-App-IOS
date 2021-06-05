//
//  CategoryCell.swift
//  multiScreenLecture
//
//  Created by moumen isawe on 20/03/2021.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage:UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var movieMainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.setRounded(corner: 4)
      /*  mainView.setRounded(corner: 10)*/
        
    }

    func configure(movieName:String,movieDescription:String,moviePath:String){
        self.movieTitle.text = movieName
        self.movieDescription.text = movieDescription
        self.movieImage.load(url: URL(string: "https://image.tmdb.org/t/p/original\(moviePath)")!)
    }
}
extension UIView{
    func setRounded(corner:CGFloat ){
        self.layer.cornerRadius = corner
        self.layer.masksToBounds  = true
    }
}
