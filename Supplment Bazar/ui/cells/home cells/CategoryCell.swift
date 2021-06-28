//
//  CategoryCell.swift
//  Dizney
//
//  Created by Ameer on 03/02/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: CategoryLabel!
    
    func setup(data: ProductResponse) {
        lblTitle.text = data.name
        imgView.load(image: data.logo ?? "")
    }
    
}

import SDWebImage
extension UIImageView {
    
    func load(image url: String) {
        self.sd_setImage(with: URL(string: url), completed: nil)
    }
}
