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
        imgView.setImage(data.image, placeholder: nil, showIndicator: true, completion: nil)
        lblPrice.text = "\(data.price ?? "") \(data.currency ?? "")"
        lblName.text = data.name
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
        if let action = favouriteAction {
            action()
        }
    }
    
}
