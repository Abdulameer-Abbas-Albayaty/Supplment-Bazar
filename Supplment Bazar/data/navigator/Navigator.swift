//
//  Navigator.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import Foundation
import UIKit

struct StoryBoardIDS {
    static let changePassword = "changePassword"
    static let about = "about"
    static let productDetails = "product_details"
    static let shops = "shops"
    static let products = "products_vc"
    static let brands = "brands"
    static let cart = "cart"
    static let stores = "stores"
}

struct StartPoints {
    // if loged in
    static let tabbar = "tabbar"
    static let tips = "tips"
    static let auth = "login"
}

// story boards
struct StoryBoards {
    static let tips = "Tips"
    static let auth = "Auth"
    static let tabs = "Main"
    static let order = "Order"
}

class Navigator {
    
    static func start() -> UIViewController {
        return toTabs()
    }
    
    static func toTips() -> UIViewController {
        let vc = UIStoryboard(name: StoryBoards.tips, bundle: nil).instantiateViewController(withIdentifier: StartPoints.tips)
        return vc
    }
    
    static func toAuth() -> UIViewController {
        let vc = UIStoryboard(name: StoryBoards.auth, bundle: nil).instantiateViewController(withIdentifier: StartPoints.auth)
        return vc
    }
    
    static func toTabs() -> UIViewController {
        let vc = UIStoryboard(name: StoryBoards.tabs, bundle: nil).instantiateViewController(withIdentifier: StartPoints.tabbar)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    static func toProductDetails(id: String) -> ProductDetailsViewController {
        let vc = UIStoryboard(name: StoryBoards.tabs, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.productDetails) as! ProductDetailsViewController
        vc.productId = id
        return vc
    }
    
    static func toProducts(id: String, type: HomeKeys) -> ProductsViewController {
        let vc = UIStoryboard(name: StoryBoards.tabs, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.products) as! ProductsViewController
        vc.id = id
        vc.type = type
        return vc
    }
    
    static func toBrands() -> UIViewController {
        let vc = UIStoryboard(name: StoryBoards.tabs, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.brands) 
        return vc
    }
    
    static func toCart() -> UIViewController {
        let vc = UIStoryboard(name: StoryBoards.order, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.cart)
        return vc
    }
    
    static func toStores() -> UIViewController {
        let vc = UIStoryboard(name: StoryBoards.tabs, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.stores)
        return vc
    }
    
//    static func toShopDetails(shopId: Int) -> UIViewController {
//        let vc = UIStoryboard(name: StoryBoards.details, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.shops) as! ShopViewController
//        vc.shopId = shopId
//        return vc
//    }
    
}
