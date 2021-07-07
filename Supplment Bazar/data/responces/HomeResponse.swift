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

struct GenericMetaAPIResponse<T: Decodable>: Decodable {
    let success: Bool
    let message: String?
    let data: T?
    let meta: MetaData
}

struct MetaData: Decodable {
    let current_page: Int
    let last_page: Int
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
    let id: String
    let name: String?
    let logo: String?
    
    let price: String?
    let description: String?
    let image: String?
    
    let rating: String?
    let cover: String?
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
