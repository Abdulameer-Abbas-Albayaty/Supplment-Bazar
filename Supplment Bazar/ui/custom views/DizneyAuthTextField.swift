//
//  BananAuthTextField.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/14/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class DizneyAuthTextField: UITextField {
    
    @IBInspectable var image: UIImage? {
        didSet {
            updateView()
        }
    }
    
    var padding : UIEdgeInsets?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        font = AppFont.textField
        textColor = UIColor.textPrimary
        borderStyle = .none
        layer.cornerRadius = 8
        backgroundColor = UIColor.secondaryBackground
        
        if Locale.current.languageCode == "ar" {
            padding = UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 48)
        } else {
            padding = UIEdgeInsets(top: 2, left: 48, bottom: 2, right: 16)
        }
        
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding!)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding!)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding!)
    }
    
    func updateView() {
        if let image = image {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            view.addSubview(imageView)
            imageView.frame = CGRect(x: Locale.current.languageCode == "ar" ? -8 : 16, y: ((view.frame.height / 2) - 10), width: 20.0, height: 20.0)
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = UIColor.textSecondary
            leftView = view
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }

}
