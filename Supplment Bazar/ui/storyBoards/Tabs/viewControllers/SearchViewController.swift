//
//  SearchViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import UIKit

private let headerId = "headerId"
private let shopCellId = "shopCellId"

struct SearchResponse : Decodable {
    let products: [ProductResponse]?
    let merchants: [ProductResponse]?
}

class SearchViewController: BaseViewController<SearchViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var results = [String]()
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    fileprivate var response: SearchResponse?
    fileprivate var query = String()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib(nibName: "ShopCardCell", bundle: nil), forCellWithReuseIdentifier: shopCellId)
        
        segmentControl.addTarget(self, action: #selector(handleSegment), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupUI()
    }
    
    func setupUI() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc
    fileprivate func handleSegment() {
        collectionView.reloadData()
    }
    
    fileprivate func callAPI() {
        viewModel.get(query: query) { (res) in
            if let res = res {
                self.response = res
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return response?.products?.count ?? 0
        } else if segmentControl.selectedSegmentIndex == 1 {
            return response?.merchants?.count ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentControl.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
            if let data = response?.products {
                cell.setup(data: data[indexPath.row])
            }
            return cell
        } else if segmentControl.selectedSegmentIndex == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopCellId, for: indexPath) as! ShopCell
            if let data = response?.merchants {
                cell.setup(data: data[indexPath.row])
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentControl.selectedSegmentIndex == 0 {
            return CGSize(width: collectionView.frame.width, height: 120)
        } else if segmentControl.selectedSegmentIndex == 1 {
            return CGSize(width: collectionView.frame.width - 48, height: 300)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if segmentControl.selectedSegmentIndex == 0 {
            return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        } else if segmentControl.selectedSegmentIndex == 1 {
            return UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        }
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentControl.selectedSegmentIndex == 0 {
//            self.navigationController?.pushViewController(Navigator.toProductDetails(slug: response?.products?[indexPath.row].slug ?? ""), animated: true)
        } else if segmentControl.selectedSegmentIndex == 1 {
//            self.navigationController?.pushViewController(Navigator.toShopDetails(shopId: response?.merchants?[indexPath.row].slug ?? 1), animated: true)
        }
    }

}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
        if let text = searchBar.text, text != query {
            response = nil
            self.query = text
            collectionView.reloadData()
            callAPI()
        }
    }
    
}

