//
//  CategoriesGroup.swift
//  Dizney
//
//  Created by Ameer on 03/02/2021.
//

import UIKit

class CategoriesGroup: UICollectionViewCell {
    
    @IBOutlet weak var collecionView: UICollectionView!
    var data = [ProductResponse]()
    
    func setData(data: [ProductResponse]) {
        collecionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.data = data
        collecionView.reloadData()
    }
}

extension CategoriesGroup: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.setup(data: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    }
    
}
