//
//  FavoriteViewController.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 04/06/2021.
//

import UIKit

class FavoriteViewController: UIViewController, DataChange {
    func onChangeData() {
        
    }
    
    
    
    @IBOutlet weak var uiTableView: UITableView!
    
    var data = [Favorite]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        
        uiTableView.dataSource = self
        uiTableView.delegate = self
        
       // fetchData()
        
    }
    
    
    fileprivate func fetchData(){
        do{
            self.data = try context.fetch(Favorite.fetchRequest())
            DispatchQueue.main.async {
                self.uiTableView.reloadData()
            }

        }catch{
            
        }

}

}

extension FavoriteViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
       
        cell.configure(movieName: data[indexPath.row].original_title!, movieDescription: data[indexPath.row].overview!, moviePath: data[indexPath.row].poster_path!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewC = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                viewC.favorite = data[indexPath.row]
                viewC.onChange = self
               present(viewC, animated: true, completion: nil)

    }
    
    // to delete the item
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {return}
        let lineToRemove = self.data[indexPath.row]
        do{
            try self.context.delete(lineToRemove)
        }catch{
            
        }
        self.fetchData()
    }

    
    
}
