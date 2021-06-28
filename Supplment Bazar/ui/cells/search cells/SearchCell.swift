//
//  SearchCell.swift
//  Dizney
//
//  Created by Ameer on 18/01/2021.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: CorneredImageView!
    
    func setup(data: ProductResponse) {
        lblTitle.text = data.name
        lblPrice.text = "\(data.price ?? 0)"
        lblDetails.text = data.about
        
        if let img = data.image {
            imgView.load(image: img)
        }
    }
}
