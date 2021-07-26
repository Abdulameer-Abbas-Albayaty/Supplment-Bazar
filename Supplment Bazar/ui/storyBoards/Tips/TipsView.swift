//
//  TipsView.swift
//  Sayaraty
//
//  Created by Ameer on 6/23/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class TipsView: UIView {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    
    func setupView(view: UIView) {
        view.addSubview(self)
        self.frame = view.frame
        self.backgroundColor = UIColor.secondaryBackground
    }
    
    func update(image: UIImage, title: String, details: String) {
        imgView.image = image
        lblTitle.text = title
        lblDetails.text = details
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        NotificationCenter.default.post(name: .skipTapped, object: nil)
    }
    
}

extension Notification.Name {
    static let skipTapped = Notification.Name("Skip")
}
