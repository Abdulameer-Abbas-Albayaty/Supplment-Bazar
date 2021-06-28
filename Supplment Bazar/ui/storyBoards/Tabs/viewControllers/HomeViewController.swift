//
//  HomeViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 27/02/2021.
//

import UIKit

private let category_cell_id = "category_cell_id"
private let headerId = "headerId"

private let toDetails = "toDetails"

enum HomeKeys: String {
    case brands, products, merchants
}

class HomeViewController: BaseViewController<HomeViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var response = [HomeResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ItemsGroup", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib(nibName: "ShopCardCell", bundle: nil), forCellWithReuseIdentifier: "big_cell")
        collectionView.register(UINib(nibName: "CategoriesGroup", bundle: nil), forCellWithReuseIdentifier: category_cell_id)
        collectionView.register(UINib(nibName: "HomeCollectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        viewModel.getHome { sections in
            if let secs = sections {
                self.response = secs.sections
                self.collectionView.reloadData()
            }
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return response.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if response[section].section_type == HomeKeys.brands.rawValue {
            return 1
        } else if response[section].section_type == HomeKeys.products.rawValue {
            return 1
        } else if response[section].section_type == HomeKeys.merchants.rawValue {
            return response[section].section_data?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if response[indexPath.section].section_type == HomeKeys.brands.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: category_cell_id, for: indexPath) as! CategoriesGroup
            if let data = response[indexPath.section].section_data {
                cell.setData(data: data)
            }
            return cell
        } else if response[indexPath.section].section_type == HomeKeys.products.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemsGroupCell
            if let products = response[indexPath.section].section_data {
                cell.setup(arr: products)
                cell.selectAction = { (index) in
                    self.navigationController?.pushViewController(Navigator.toProductDetails(slug: products[index].id ?? ""), animated: true)
                }
                cell.favouriteAction = { (index) in
                    print(products[index])
                }
            }
            return cell
        } else if response[indexPath.section].section_type == HomeKeys.merchants.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "big_cell", for: indexPath) as! ShopCell
            if let merchant = response[indexPath.section].section_data {
                cell.setup(data: merchant[indexPath.row])
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "big_cell", for: indexPath) as! ShopCell
        if let merchant = response[indexPath.section].section_data {
            cell.setup(data: merchant[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if response[indexPath.section].section_type == HomeKeys.brands.rawValue {
            return CGSize(width: collectionView.frame.width, height: 120)
        } else if response[indexPath.section].section_type == HomeKeys.products.rawValue {
            let height = collectionView.frame.height / 2.8
            let estimated = height < 230 ? 230 : height
            return CGSize(width: collectionView.frame.width, height: estimated)
        } else if response[indexPath.section].section_type == HomeKeys.merchants.rawValue {
            let height = collectionView.frame.height / 2.7
            let estimated = height < 260 ? 260 : height
            return CGSize(width: collectionView.frame.width - 32, height: estimated)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if response[indexPath.section].section_type == HomeKeys.merchants.rawValue {
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! HomeCollectionHeader
        let headerData = response[indexPath.section]
        header.setup(title: headerData.section_title)
        header.viewAllAction = {
            if headerData.section_type == HomeKeys.brands.rawValue {
                self.performSegue(withIdentifier: "toCategories", sender: nil)
            } else if headerData.section_type == HomeKeys.products.rawValue {
                self.navigationController?.pushViewController(Navigator.toProducts(sectionId: headerData.section_id), animated: true)
            }
        }
        return header
    }
    
}
