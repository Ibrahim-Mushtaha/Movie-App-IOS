//
//  HomeViewController.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 27/05/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!

    var popularMovie = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
        getMovie()
        
    }
    
    

}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovie.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
       
        cell.movieTitle.text = popularMovie[indexPath.row].title
        cell.movieDescription.text = popularMovie[indexPath.row].overview
        cell.movieImage.load(url: URL(string: "https://image.tmdb.org/t/p/original\(popularMovie[indexPath.row].poster_path)")!)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewC = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                //viewC.category = data[indexPath.row]
               present(viewC, animated: true, completion: nil)
                
               // self.dataRow = data[indexPath.row]
        
        print("Selected item \(popularMovie[indexPath.row])")
        
      //  tableView.deselectRow(at: indexPath, animated: true)
    
        /* let vc  = DetailVC()
        vc.category = data[indexPath.row]
       present(vc, animated: true)*/
    }
    
    
    func getMovie(){
        let session = URLSession.shared
        var movieResults = [Movie]()
        let page = "1"
        let lang = "en-US"
        let apiKey = "28e048b6b84fcf21173939d6517a99ce"
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?page=\(page)&api_key=\(apiKey)&language=\(lang)"){
            let task  = session.dataTask(with: url) { (data, res, error) in
                let responseBody =  String(data: data!, encoding: .utf8)
                let decoder = JSONDecoder()

                do {
                                guard let data = data else { return }
                                let response = try JSONDecoder().decode(MovieResponse.self, from: data)

                                DispatchQueue.main.async {
                                 //   self.popularMovie = response
                                    for movie in response.results {
                                       movieResults.append(movie)
                                        print("Movie Object is ==> ", movie.original_title)
                                    }

                                    self.popularMovie = movieResults

                                    self.tableView.reloadData()
                                    
                                    print("Finished loading Movies")
                                }
                            } catch {
                                print("Failed to decode: ", error)
                            }
                print(responseBody)
            }
            task.resume()
        }
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


