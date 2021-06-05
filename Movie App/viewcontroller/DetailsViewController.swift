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

    @IBOutlet weak var movieCastingTeamList: UICollectionView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var uiRoundedContinar: UIView!
    
    @IBOutlet weak var uiFavoriteImage: UIButton!
    
    @IBOutlet weak var movieReleaseData: UILabel!
    @IBOutlet weak var uiReleaseContainer: UIView!
    
    var onChange:DataChange!
    
    var isAdded = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        do {
            let favorites = try context.fetch(Favorite.fetchRequest())
            DispatchQueue.main.async {
            if let movie = self.movie{
                for favorite in favorites {
                    let favObject = favorite as! Favorite
                    if(favObject.original_title == movie.original_title ){
                        print("movie is add in data core")
                        self.uiFavoriteImage.imageView?.image = UIImage(named: "star.fill")
                        self.uiFavoriteImage.imageView?.tintColor = UIColor.red
                        self.isAdded = true
                    }
                }
                
        
                
            }else {
                for favorite in favorites {
                    if((favorite as! Favorite).original_title == self.favorite?.original_title){
                        print("favorite movie is add in data core")
                        self.uiFavoriteImage.imageView?.image = UIImage(named: "star.fill")
                        self.uiFavoriteImage.imageView?.tintColor = UIColor.red
                        self.isAdded = true
                    }
                }
            
                if self.favorite == nil {
                    self.favorite = Favorite(context: self.context)
                    self.favorite?.movie_id = self.favorite?.movie_id
                    self.favorite?.overview = self.favorite?.overview
                    self.favorite?.original_title = self.favorite?.original_title
                    self.favorite?.poster_path = self.favorite?.poster_path
                    self.favorite?.release_date = self.favorite?.release_date
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
            self.movieReleaseData.text = movie.release_date
            
            movieImageView.load(url: URL(string: "\(Constant.BASICIMAGEURL)\(movie.poster_path)")!)
        
        }else{
            self.movieTitle.text = favorite!.original_title
            self.movieDescription.text = favorite?.overview
            self.movieReleaseData.text = favorite?.release_date
            
         /*   movieImageView.load(url: URL(string: "https://image.tmdb.org/t/p/original\(favorite?.poster_path)")!)
             */
        }
        
        uiReleaseContainer.dropShadow()
        uiReleaseContainer.addCorner()
        uiRoundedContinar.dropShadow()
        uiRoundedContinar.addCorner()
        
    }
    

    @IBAction func uiFavoritebtn(_ sender: UIButton) {
    
        if(isAdded){
        uiFavoriteImage.imageView?.image = UIImage(named: "star.fill")
        uiFavoriteImage.imageView?.tintColor = UIColor.red
            deleteFromCoreData(favorite: self.favorite!)
        }else {
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
        }
    }
    
    
    func deleteFromCoreData(favorite:Favorite){
        let lineToRemove = favorite
        do{
            try self.context.delete(lineToRemove)
            self.dismiss(animated: true, completion: nil)
            self.onChange.onChangeData()
        }catch{
            
        }
    }
}

protocol DataChange {
    func onChangeData()
}
