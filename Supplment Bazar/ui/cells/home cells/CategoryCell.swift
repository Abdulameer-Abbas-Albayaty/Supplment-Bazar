//
//  CategoryCell.swift
//  Supplment Bazar
//
//  Created by Ameer on 01/07/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    var imgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 16
        img.layer.masksToBounds = true
        return img
    }()
    
    var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        return lbl
    }()
    
    func setup(data: ProductResponse) {
        imgView.image = #imageLiteral(resourceName: "karada group")
        self.addSubview(imgView)
        self.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lblTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        addGrad()
        lblTitle.text = data.name
    }
    
    func addGrad() {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.black.cgColor , UIColor.clear.cgColor]
        layer.endPoint = CGPoint(x: 0.8, y: 0.8)
        layer.cornerRadius = 16
        self.layer.insertSublayer(layer, above: imgView.layer)
        layer.frame = self.bounds
    }
    
}
