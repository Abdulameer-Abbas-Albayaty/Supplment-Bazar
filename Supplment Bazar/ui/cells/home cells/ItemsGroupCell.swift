//
//  FoodsGroupCell.swift
//  Dizney
//
//  Created by Ameer on 1/6/21.
//

import UIKit

class ItemsGroupCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var products = [ProductResponse]()
    
    var selectAction: ((_ index: Int) -> ())?
    var favouriteAction: ((_ index: Int) -> ())?
    
    func setup(arr: [ProductResponse]) {
        collectionView.register(UINib(nibName: "ItemCardCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.products = arr
        collectionView.reloadData()
    }
    
}

extension ItemsGroupCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCell
        cell.setup(data: products[indexPath.row])
        cell.favouriteAction = {
            if let action = self.favouriteAction {
                action(indexPath.row)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height * 0.8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let action = selectAction {
            action(indexPath.row)
        }
    }
    
}
