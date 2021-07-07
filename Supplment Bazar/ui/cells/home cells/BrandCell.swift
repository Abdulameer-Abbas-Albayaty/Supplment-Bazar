//
//  CategoryCell.swift
//  Dizney
//
//  Created by Ameer on 03/02/2021.
//

import UIKit

class BrandCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: CategoryLabel!
    
    func setup(data: ProductResponse) {
        lblTitle.text = data.name
        imgView.setImage(data.logo, showIndicator: true)
    }
    
}

