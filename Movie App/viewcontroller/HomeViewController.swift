//
//  HomeViewController.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 27/05/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var uiSliderView: UICollectionView!
    
    @IBOutlet weak var uiPageControl: UIPageControl!
    var timer:Timer?
    var currentCellIndex = 0
    var webserviceImage = ["image2","image1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        
        uiPageControl.numberOfPages = webserviceImage.count
        
    }
    
    @objc func slideToNext(){
        if currentCellIndex < webserviceImage.count - 1 {
            currentCellIndex = currentCellIndex + 1
        } else{
           currentCellIndex = 0
        }
        
        uiPageControl.currentPage = currentCellIndex
        
        uiSliderView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    

}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return webserviceImage.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = uiSliderView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
    
    cell.uiImageView.image = UIImage(named: webserviceImage[indexPath.row])
    
    
    return cell
}
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (uiSliderView.bounds.size.width/2) - 12, height:(uiSliderView.bounds.size.height/3) - 20)
    }
    
}

