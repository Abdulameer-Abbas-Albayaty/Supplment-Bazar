//
//  HomeCollectionHeader.swift
//  Dizney
//
//  Created by Ameer on 05/02/2021.
//

import UIKit

class HomeCollectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var viewAllAction: (() -> ())?
    
    func setup(title: String) {
        lblTitle.text = title
    }
    
    @IBAction func viewAllTapped(_ sender: Any) {
        if let action = viewAllAction {
            action()
        }
    }
    
}
