//
//  ProductsViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 09/06/2021.
//

import UIKit

class ProductsViewController: BaseViewController<ProductViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var id: String?
    var type: HomeKeys?
    
    fileprivate var page = 1
    fileprivate var isPaginationEnabled = false
    fileprivate var products = [ProductResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Products".getLocalized()
        collectionView.register(UINib(nibName: "ItemCardCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        viewModel.dataObserver.observe { (res) in
            if let res = res {
                self.isPaginationEnabled = res.meta.current_page != res.meta.last_page
                res.data?.forEach({ (brand) in
                    self.products.append(brand)
                })
                self.collectionView.reloadData()
            }
        }
        callProducts()
    }
    
    fileprivate func callProducts() {
        guard let id = id else {return}
        guard let type = type else {return}
        switch type {
        case .brands:
            viewModel.getByBrand(page: page, brandId: id)
        case .products:
            viewModel.getBySectionId(page: page, sectionId: id)
        case .stores:
            viewModel.getByStore(page: page, storeId: id)
        case .categories:
            viewModel.getByCategory(page: page, categoryId: id)
        case .offers:
            break
        }
    }

}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCell
        cell.setup(data: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height / 2.8
        let estimated = height < 230 ? 230 : height
        let width = (collectionView.frame.width - 32 - 10) / 2
        return .init(width: width, height: estimated)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if products.count != 0 && indexPath.row == products.count - 2 && isPaginationEnabled {
            page += 1
            callProducts()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(Navigator.toProductDetails(id: products[indexPath.row].id), animated: true)
    }
    
}
