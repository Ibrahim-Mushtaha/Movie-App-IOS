//
//  ViewController.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 25/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 4
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addCorner(value:Int = 4){
        layer.masksToBounds = true
        layer.cornerRadius = 4
    }
    
    

}


