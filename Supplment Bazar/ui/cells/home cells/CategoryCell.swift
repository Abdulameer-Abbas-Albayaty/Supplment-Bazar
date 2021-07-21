//
//  CategoryCell.swift
//  Supplment Bazar
//
//  Created by Ameer on 01/07/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCategory: UILabel!
    
    func setup(data: ProductResponse) {
        lblCategory.text = data.name
    }
    
//    func addGrad() {
//        let layer = CAGradientLayer()
//        layer.colors = [UIColor.black.cgColor , UIColor.clear.cgColor]
//        layer.endPoint = CGPoint(x: 0.8, y: 0.8)
//        layer.cornerRadius = 16
//        self.layer.insertSublayer(layer, above: imgView.layer)
//        layer.frame = self.bounds
//    }
    
}
