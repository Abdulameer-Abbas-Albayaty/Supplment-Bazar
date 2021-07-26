//
//  HomeViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 27/02/2021.
//

import UIKit

private let brand_cell_id = "brand_cell_id"
private let offers_cell_id = "offers_cell_id"
private let headerId = "headerId"

private let toDetails = "toDetails"

enum HomeKeys: String {
    case brands, products, stores, categories, offers
}

class HomeViewController: BaseCartViewController<HomeViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var response = [HomeResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
        collectionView.register(UINib(nibName: "ItemsGroup", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib(nibName: "ShopCardCell", bundle: nil), forCellWithReuseIdentifier: "big_cell")
        collectionView.register(UINib(nibName: "BrandsGroup", bundle: nil), forCellWithReuseIdentifier: brand_cell_id)
        collectionView.register(OffersCell.self, forCellWithReuseIdentifier: offers_cell_id)
        
        collectionView.register(UINib(nibName: "HomeCollectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        callAPI()
    }
    
    fileprivate func callAPI() {
        viewModel.getHome { sections in
            self.response = sections.sections
            self.collectionView.reloadData()
        }
    }
    
    func routeTo(_ id: String,_ type: HomeKeys) {
        switch type {
        case .brands:
            self.navigationController?.pushViewController(Navigator.toProducts(id: id, type: .brands), animated: true)
        case .categories:
            self.navigationController?.pushViewController(Navigator.toProducts(id: id, type: .categories), animated: true)
        case .products:
            self.navigationController?.pushViewController(Navigator.toProductDetails(id: id), animated: true)
        case .stores:
            print("view all stores")
        default:
            break
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return response.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if response[section].section_type == HomeKeys.brands.rawValue || response[section].section_type == HomeKeys.categories.rawValue || response[section].section_type == HomeKeys.offers.rawValue {
            return 1
        } else if response[section].section_type == HomeKeys.products.rawValue {
            return 1
        } else if response[section].section_type == HomeKeys.stores.rawValue {
            return response[section].section_data?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if response[indexPath.section].section_type == HomeKeys.brands.rawValue || response[indexPath.section].section_type == HomeKeys.products.rawValue || response[indexPath.section].section_type == HomeKeys.categories.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brand_cell_id, for: indexPath) as! BrandsGroup
            if let data = response[indexPath.section].section_data {
                cell.setData(data: data, type: HomeKeys(rawValue: response[indexPath.section].section_type) ?? .brands)
                cell.didTap = { (id, type) in
                    self.routeTo(id, type)
                }
            }
            return cell
        } else if response[indexPath.section].section_type == HomeKeys.stores.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "big_cell", for: indexPath) as! ShopCell
            if let merchant = response[indexPath.section].section_data {
                cell.setup(data: merchant[indexPath.row])
            }
            return cell
        } else if response[indexPath.section].section_type == HomeKeys.offers.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: offers_cell_id, for: indexPath) as! OffersCell
            cell.items = response[indexPath.section].section_data ?? []
            cell.selectItem = { id in
                self.navigationController?.pushViewController(Navigator.toProductDetails(id: id), animated: true)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch response[indexPath.section].section_type {
        case HomeKeys.offers.rawValue:
            let width = collectionView.frame.width
            return CGSize(width: width, height: width * 0.7)
        case HomeKeys.brands.rawValue, HomeKeys.categories.rawValue :
            return CGSize(width: collectionView.frame.width, height: 120)
        case HomeKeys.products.rawValue:
            let height = collectionView.frame.height / 2.8
            let estimated = height < 230 ? 230 : height
            return CGSize(width: collectionView.frame.width, height: estimated)
        case HomeKeys.stores.rawValue:
            let height = collectionView.frame.height / 2.7
            let estimated = height < 260 ? 260 : height
            return CGSize(width: collectionView.frame.width - 32, height: estimated)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if response[indexPath.section].section_type == HomeKeys.stores.rawValue {
            self.navigationController?.pushViewController(Navigator.toProducts(id: response[indexPath.row].section_id, type: .stores), animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if response[section].section_type == HomeKeys.offers.rawValue {
            return .zero
        } else {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! HomeCollectionHeader
        let headerData = response[indexPath.section]
        header.setup(title: headerData.section_title)
        header.viewAllAction = {
            self.viewAllTapped(section: headerData)
        }
        return header
    }
    
    func viewAllTapped(section: HomeResponse) {
        switch section.section_type {
        case HomeKeys.brands.rawValue:
            self.navigationController?.pushViewController(Navigator.toBrands(), animated: true)
        case HomeKeys.products.rawValue:
            self.navigationController?.pushViewController(Navigator.toProducts(id: section.section_id, type: .products), animated: true)
        case HomeKeys.stores.rawValue:
            print("view all stores")
            self.navigationController?.pushViewController(Navigator.toStores(), animated: true)
        default:
            break
        }
    }
    
}
