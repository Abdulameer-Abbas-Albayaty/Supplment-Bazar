//
//  Urls.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/23/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import Foundation

private let server = "https://api.iraqbodybuilding.app"
private let baseUrl = "\(server)/api/v1"

struct AuthURL {
    static let login = "\(baseUrl)/auth/login"
    static let signUp = "\(baseUrl)/auth/register"
    static let verifyOTP = "\(baseUrl)/users/verify"
    static let resendOTP = "\(baseUrl)/users/verify/resend"
    static let logout = "\(baseUrl)/auth/logout"
    
    static let profile = "\(baseUrl)/users/me"
}

struct HomeURL {
    static let home = "\(baseUrl)/home"
    // query
    static let search = "\(baseUrl)/products/search"
    static let shops = "\(baseUrl)/shops"
    
    static let allBrands = "\(baseUrl)/brands"
    // get with section id
    static let viewAllProduct = "\(baseUrl)/sections/"
    // product id
    static let productDetails = "\(baseUrl)/products/"
    static let shopDetails = "\(baseUrl)/shops/"
    
    static let categoryDetails = "\(baseUrl)/categories/"
    static let brandDetails = "\(baseUrl)/brands/"
    
    static let allStores = "\(baseUrl)/stores"
}

struct StoreURL {
    static let getStoreDetails = "\(baseUrl)/stores/"
}

struct CartUrl {
    // post
    static let add = "\(baseUrl)/carts"
    static let get = "\(baseUrl)/carts"
    static let edit = "\(baseUrl)/carts/"
    // delete
    static let delete = "\(baseUrl)/carts/"
    static let checkout = "\(baseUrl)/checkouts"
}
