//
//  PopUp.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 5/2/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class PopUp: UIView {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var actionButton: DizneyButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var mainView: CornerView!
    var action: (() -> ())?
    
    func addToView(_ view: UIView) {
        view.addSubview(self)
        self.frame = view.frame
        actionButton.isHidden = true
        self.isHidden = true
    }
    
    func hidePop() {
        self.isHidden = true
    }
    
    func configCancelable(messgae: String, image: UIImage) {
        self.cancelButton.isHidden = false
        self.actionButton.isHidden = true
        lblMessage.text = messgae
        imgView.image = image
        self.isHidden = false
        
        animation()
    }
    
    func configActionOnly(messgae: String, image: UIImage, actionTitle: String, action: @escaping () -> ()) {
        self.cancelButton.isHidden = true
        self.actionButton.isHidden = false
        lblMessage.text = messgae
        imgView.image = image
        actionButton.setTitle(title: actionTitle)
        self.action = action
        self.isHidden = false
        
        animation()
    }
    
    func configWithAction(messgae: String, image: UIImage, actionTitle: String, action: @escaping () -> ()) {
        lblMessage.text = messgae
        imgView.image = image
        actionButton.setTitle(title: actionTitle)
        self.cancelButton.isHidden = false
        actionButton.isHidden = false
        self.action = action
        self.isHidden = false
        
        animation()
    }
    
    func animation() {
        mainView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5) {
            self.mainView.transform = .identity
        }
    }
    
    @objc
    fileprivate func handleActionTapped() {
        if let action = action {
            action()
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.isHidden = true
    }
    
}
