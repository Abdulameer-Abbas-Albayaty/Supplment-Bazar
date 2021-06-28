//
//  NoDataView.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 7/22/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    
    @IBOutlet var mainImage : UIImageView!
    @IBOutlet var messageLbl : UILabel!
    @IBOutlet var viewButton : UIButton!
       
    // MARK: - FUNCS
    func setupNoDataView(mainView : UIView) {
        self.frame = mainView.frame
        mainView.addSubview(self)
        self.isHidden = true
    }
    
    func updateData(messageImage : UIImage, message : String, buttonTitle : String?) {
        self.mainImage.image = messageImage
        self.layoutIfNeeded()
        self.messageLbl.text = message
        viewButton.setTitle(buttonTitle, for: .normal)
        self.isHidden = false
    }
    
}
