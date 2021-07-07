//
//  CategoriesGroup.swift
//  Dizney
//
//  Created by Ameer on 03/02/2021.
//

import UIKit

private let productCell = "product_cell"
private let brandCell = "brand_cell"
private let categoryCell = "category_cell"

class BrandsGroup: UICollectionViewCell {
    
    @IBOutlet weak var collecionView: UICollectionView!
    var data = [ProductResponse]()
    
    var didTap: ((_ id: String, _ type: HomeKeys) -> ())?
    
    var type: HomeKeys = .brands
    
    func setData(data: [ProductResponse], type: HomeKeys) {
        print(type)
        self.type = type
        switch type {
        case .brands:
            collecionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: brandCell)
        case .products:
            collecionView.register(UINib(nibName: "ItemCardCell", bundle: nil), forCellWithReuseIdentifier: productCell)
        case .categories:
            collecionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCell)
        default:
            break
        }
        self.data = data
        collecionView.reloadData()
    }
    
}

extension BrandsGroup: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .products:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCell, for: indexPath) as! ItemCell
            cell.setup(data: data[indexPath.row])
            return cell
        case .brands:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brandCell, for: indexPath) as! BrandCell
            cell.setup(data: data[indexPath.row])
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath) as! CategoryCell
            cell.setup(data: data[indexPath.row])
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch type {
        case .products:
            let height = collectionView.frame.height
            return CGSize(width: height * 0.8, height: height)
        case .brands:
            return CGSize(width: 160, height: collectionView.frame.height)
        case .categories:
            return CGSize(width: 160, height: collectionView.frame.height)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tap = didTap {
            tap(data[indexPath.row].id, type)
        }
    }
    
}
