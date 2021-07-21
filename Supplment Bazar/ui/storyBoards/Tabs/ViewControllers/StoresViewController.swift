//
//  StoresViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 18/07/2021.
//

import UIKit

class StoresViewController: BaseViewController<StoresViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var stores = [ProductResponse]()
    fileprivate var page = 1
    fileprivate var isPaginationEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ShopCardCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        viewModel.dataObserver.observe { (data) in
            if let data = data {
                self.isPaginationEnabled = data.meta.current_page != data.meta.last_page
                data.data?.forEach({ (store) in
                    self.stores.append(store)
                    self.collectionView.reloadData()
                })
            }
        }
        viewModel.get(page: page)
    }

}

extension StoresViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShopCell
        cell.setup(data: stores[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height / 2.7
        let estimated = height < 260 ? 260 : height
        return CGSize(width: collectionView.frame.width - 32, height: estimated)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if stores.count != 0 && indexPath.row == stores.count - 2 && isPaginationEnabled {
            page += 1
            viewModel.get(page: page)
        }
    }
    
}
