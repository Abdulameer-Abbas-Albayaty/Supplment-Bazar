//
//  DizneyTextView.swift
//  Dizney
//
//  Created by Ameer on 13/02/2021.
//

import UIKit

class DizneyTextView: UITextView, UITextViewDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        text = "notes".getLocalized()
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.textColor = UIColor.lightGray
        self.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.textContainerInset = UIEdgeInsets.init(top: 15, left: 9 , bottom: 15, right: 15)
        self.delegate = self
    }
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "notes".getLocalized() {
            textView.text = nil
            textColor = UIColor.textPrimary
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "notes".getLocalized()
            textView.textColor = UIColor.lightGray
        }
    }
    
}
