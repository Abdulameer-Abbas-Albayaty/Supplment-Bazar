//
//  HomeResponse.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import Foundation

struct GenericAPIResponse<T: Decodable>: Decodable {
    let success: Bool
    let message: String?
    let data: T?
}

struct HomeSections : Decodable {
    let sections: [HomeResponse]
}

struct HomeResponse: Decodable {
    let section_title: String
    let section_id: String
    let section_type: String
    let section_data: [ProductResponse]?
}

struct ProductResponse: Decodable {
    let id: String?
    let name: String?
    let logo: String?
    
    let price: Double?
    let description: String?
    let image: String?
    
    let about: String?
    let rating: String?
}


struct ShopData: Decodable {
    let id: Int
    let name: String
    let about: String
    let logo: String
    let cover: String
    let status: Int
    let address: String
    let rating: String?
}
