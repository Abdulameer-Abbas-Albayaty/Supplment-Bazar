//
//  ShoppingCenterHeader.swift
//  Dizney
//
//  Created by Ameer on 1/11/21.
//

import UIKit

class ShoppingCenterHeader: UICollectionReusableView {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var logo: CircularImageView!
        
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    func setup(data: ShopData) {
        lblTitle.text = data.name
        lblAddress.text = data.address
        
        lblRating.text = data.rating ?? "0"
        coverImageView.setImage(data.cover, placeholder: nil, showIndicator: true, completion: nil)
        logo.setImage(data.logo, placeholder: nil, showIndicator: true, completion: nil)
    }
    
}
