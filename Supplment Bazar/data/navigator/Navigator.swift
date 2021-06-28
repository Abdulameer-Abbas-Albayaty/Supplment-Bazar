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
}

struct StartPoints {
    // if loged in
    static let tabbar = "tabbar"
    // if tips not shown
    static let tips = "tips"
    // auth
    static let auth = "auth"
}

// story boards
struct StoryBoards {
    static let tips = "Tips"
    static let auth = "Auth"
    static let tabs = "Main"
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
    
    static func toProductDetails(slug: String) -> ProductDetailsViewController {
        let vc = UIStoryboard(name: StoryBoards.tabs, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.productDetails) as! ProductDetailsViewController
        vc.productId = slug
        return vc
    }
    
    static func toProducts(sectionId: String) -> ProductsViewController {
        let vc = UIStoryboard(name: StoryBoards.tabs, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.products) as! ProductsViewController
        
        return vc
    }
    
//    static func toShopDetails(shopId: Int) -> UIViewController {
//        let vc = UIStoryboard(name: StoryBoards.details, bundle: nil).instantiateViewController(withIdentifier: StoryBoardIDS.shops) as! ShopViewController
//        vc.shopId = shopId
//        return vc
//    }
    
}