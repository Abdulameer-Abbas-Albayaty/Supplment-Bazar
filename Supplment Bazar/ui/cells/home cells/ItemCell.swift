//
//  ItemCell.swift
//  Dizney
//
//  Created by Ameer on 03/02/2021.
//

import UIKit


class ItemCell: UICollectionViewCell {
        @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: SpecialLabel!
    @IBOutlet weak var imgView: CorneredImageView!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    var favouriteAction: (() -> ())?
    
    func setup(data: ProductResponse) {
        if let img = data.image {
            imgView.load(image: img)
        }
        lblPrice.text = "\(data.price ?? 0)"
        lblName.text = data.name
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
        if let action = favouriteAction {
            action()
        }
    }
    
}
