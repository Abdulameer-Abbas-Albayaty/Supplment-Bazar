//
//  ShopCell.swift
//  Dizney
//
//  Created by Ameer on 03/02/2021.
//

import UIKit

class ShopCell: UICollectionViewCell {
    
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: CorneredImageView!
    
    func setup(data: ProductResponse) {
        lblName.text = data.name
        lblRate.text = data.rating ?? "Not available"
//        lblAddress.text = data.address
//        imgView.load(image: data.cover ?? "")
    }
}
