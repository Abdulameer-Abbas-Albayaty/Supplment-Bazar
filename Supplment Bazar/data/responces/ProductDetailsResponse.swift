//
//  ProductDetailsResponse.swift
//  Supplment Bazar
//
//  Created by Ameer on 27/06/2021.
//

import Foundation

struct ProductDetailsResponse: Decodable {
    let id: String
    let name: String?
    
    let price: String?
    let description: String?
    let image: String?
    
    let suggested_use: String?
    let category: String?
    
    let options: ProductOptions?
    let variants: [ProductVarients]?
    
    let about: String?
    let rating: String?
    let address: String?
    let supplement_facts: String?
    let cover: String?
    let store: StoreData?
}

struct ProductVarients: Decodable {
    let id: Int
    let image: String
    let supplement_facts: String
    let flavor: String
    let size: String
}

struct ProductOptions: Decodable {
    let flavors: [String]
    let sizes: [String]
}

struct StoreData: Decodable {
    let id: String
    let name: String
    let logo: String?
    let cover: String?
}
