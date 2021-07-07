//
//  OfferCell.swift
//  Supplment Bazar
//
//  Created by Ameer on 01/07/2021.
//

import UIKit
import FSPagerView

class OfferCell: FSPagerViewCell {
    
    @IBOutlet weak var imgView: CorneredImageView!
    
    func setup(data: ProductResponse) {
        imgView.setImage(data.image, showIndicator: true)
    }
    
}
