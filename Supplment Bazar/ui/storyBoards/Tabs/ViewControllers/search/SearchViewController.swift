//
//  SearchViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import UIKit

private let headerId = "headerId"
private let shopCellId = "shopCellId"

class SearchViewController: BaseViewController<SearchViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
        
    fileprivate var items = [ProductResponse]()
    fileprivate var query = String()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib(nibName: "ShopCardCell", bundle: nil), forCellWithReuseIdentifier: shopCellId)
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
                self.items = res
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
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        cell.setup(data: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(Navigator.toProductDetails(id: items[indexPath.row].id), animated: true)
    }

}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
        if let text = searchBar.text, text != query {
            items = []
            self.query = text
            collectionView.reloadData()
            callAPI()
        }
    }
    
}

