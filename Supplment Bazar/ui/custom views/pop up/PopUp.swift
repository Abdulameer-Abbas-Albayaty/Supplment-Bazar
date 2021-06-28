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
    
    fileprivate var actionTapped: (() -> ())?
    
    func addToView(_ view: UIView) {
        view.addSubview(self)
        self.frame = view.frame
        actionButton.isHidden = true
        self.isHidden = true
    }
    
    func hidePop() {
        self.isHidden = true
    }
    
    func config(messgae: String, image: UIImage, actionTitle: String?) {
        lblMessage.text = messgae
        imgView.image = image
        if let title = actionTitle {
            actionButton.setTitle(title: title)
            actionButton.isHidden = false
        }
        self.isHidden = false
    }
    
    func configWithAction(messgae: String, image: UIImage, actionTitle: String, action: (() -> ())?) {
        lblMessage.text = messgae
        imgView.image = image
        actionButton.setTitle(title: actionTitle)
        actionButton.addTarget(self, action: #selector(handleActionTapped), for: .touchUpInside)
        actionButton.isHidden = false
        if let action = action {
            self.actionTapped = action
        }
        self.isHidden = false
    }
    
    @objc
    fileprivate func handleActionTapped() {
        if let action = actionTapped {
            action()
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.isHidden = true
    }
    
}
