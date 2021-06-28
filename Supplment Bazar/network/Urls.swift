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
    static let signUp = "\(baseUrl)/auth/signup"
    static let verifyOTP = "\(baseUrl)/auth/signup/verify_otp"
    static let resendOTP = "\(baseUrl)/auth/signup/resend_otp"
    
    static let createChat = "\(baseUrl)/chat/user"
    static let getChatToken = "\(baseUrl)/chat/token"
    
    static let logout = "\(baseUrl)/auth/logout"
}

struct HomeURL {
    static let home = "\(baseUrl)/home"
    // query
    static let search = "\(baseUrl)/discovery/search"
    static let categories = "\(baseUrl)/discovery/categories"
    static let shops = "\(baseUrl)/shops"
    
    // get with section id
    static let viewAllProduct = "\(baseUrl)/sections/"
    // product id
    static let productDetails = "\(baseUrl)/products/"
    static let shopDetails = "\(baseUrl)/shops/"
}

struct OrderURL {
    static let makeOrder = "\(baseUrl)/customer/orders"
    static let liveOrders = "\(baseUrl)/customer/orders/live"
    static let details = "\(baseUrl)/order/"
    
    static let changeStatus = "\(baseUrl)/customer/orders/status"
}
