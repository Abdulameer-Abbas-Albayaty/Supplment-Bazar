//
//  OfferCell.swift
//  Supplment Bazar
//
//  Created by Ameer on 01/07/2021.
//

import UIKit

class OfferCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: CorneredImageView!
    
    func setup(data: ProductResponse) {
        imgView.setImage(data.image, showIndicator: true)
    }
    
}
