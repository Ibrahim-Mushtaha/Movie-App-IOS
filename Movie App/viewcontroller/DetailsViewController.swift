//
//  DetailsViewController.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 03/06/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var movie:Movie?
    var favorite: Favorite?

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var uiRoundedContinar: UIView!
    
    @IBOutlet weak var uiFavoriteImage: UIButton!
    
    var onChange:DataChange!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        do {
            let favorites = try context.fetch(Favorite.fetchRequest())
            DispatchQueue.main.async {
            if let movie = self.movie{
                for favorite in favorites {
                    if((favorite as! Favorite).original_title == movie.original_title ){
                        print("movie is add in data core")
                        self.uiFavoriteImage.imageView?.image = UIImage(named: "star.fill")
                        self.uiFavoriteImage.imageView?.tintColor = UIColor.red
                    }
                }
            }else {
                for favorite in favorites {
                    if((favorite as! Favorite).original_title == self.favorite?.original_title){
                        print("favorite movie is add in data core")
                        self.uiFavoriteImage.imageView?.image = UIImage(named: "star.fill")
                        self.uiFavoriteImage.imageView?.tintColor = UIColor.red
                    }
                }
            }
        }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        if let movie = self.movie{
            self.movieTitle.text = movie.original_title
            self.movieDescription.text = movie.overview
            
            movieImageView.load(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.poster_path)")!)
        
        }else{
            self.movieTitle.text = favorite!.original_title
            self.movieDescription.text = favorite?.overview
            
         /*   movieImageView.load(url: URL(string: "https://image.tmdb.org/t/p/original\(favorite?.poster_path)")!)
             */
        }
        
        uiRoundedContinar.dropShadow()
        uiRoundedContinar.layer.cornerRadius = 8
        uiRoundedContinar.layer.shadowRadius = 4
        
    }
    

    @IBAction func uiFavoritebtn(_ sender: UIButton) {
        if favorite == nil {
            favorite = Favorite(context: self.context)
        }
        
        favorite?.movie_id = "\(String(describing: movie?.id))"
        favorite?.original_title = movie?.original_title
        favorite?.overview = movie?.overview
        favorite?.poster_path = movie?.poster_path
        favorite?.release_date = movie?.release_date
        
        do{
            try self.context.save()
            DispatchQueue.main.async {
                    self.onChange.onChangeData()
            }
        }catch{
            
        }
        uiFavoriteImage.imageView?.image = UIImage(named: "star.fill")
        uiFavoriteImage.imageView?.tintColor = UIColor.red
    }
}

protocol DataChange {
    func onChangeData()
}
