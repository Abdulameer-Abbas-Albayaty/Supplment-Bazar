//
//  BrandsViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 29/06/2021.
//

import UIKit

class BrandsViewController: BaseViewController<BrandsViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var brands = [ProductResponse]()
    
    fileprivate var page = 1
    fileprivate var isPaginationEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "All Brands"
        collectionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
        
        callBrands()
    }
    
    fileprivate func callBrands() {
        viewModel.getBrands(page: page) { (res) in
            if let res = res {
                self.isPaginationEnabled = res.meta.current_page != res.meta.last_page
                res.data?.forEach({ (brand) in
                    self.brands.append(brand)
                })
                self.collectionView.reloadData()
            }
        }
    }

}

extension BrandsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! BrandCell
        cell.setup(data: brands[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 32 - 10) / 2
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if brands.count != 0 && indexPath.row == brands.count - 2 && isPaginationEnabled {
            page += 1
            callBrands()
        }
    }
    
}
