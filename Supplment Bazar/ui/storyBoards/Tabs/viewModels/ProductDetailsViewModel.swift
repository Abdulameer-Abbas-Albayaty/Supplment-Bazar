//
//  ProductDetailsViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import Foundation

class ProductDetailsRepo {
    
    static func get(slug: String, result: @escaping (ProductDetailsResponse?, String?) -> ()) {
        let url = "\(HomeURL.productDetails)\(slug)"
        NetworkEngine.makeRequestWithBody(url: url, method: .get, body: Optional<Int>.none) { (res: GenericAPIResponse<ProductDetailsResponse>?, error) in
            result(res?.data, error)
        }
    }
}

struct AddCartRequest: Encodable {
    let store_id: String
    let product_id: String
    let quantity: Int
}

class ProductDetailsViewModel: BaseViewModel {
    
    func get(slug: String, result: @escaping (ProductDetailsResponse?) -> ()) {
        ProductDetailsRepo.get(slug: slug) { (res, err) in
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            result(res)
        }
    }
    
    func add(body: AddCartRequest, result: @escaping (String?) -> ()) {
        NetworkEngine.makeRequestWithBody(url: CartUrl.add, method: .post, body: body) { (res: GenericAPIResponse<String>?, err) in
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            result(res?.message)
        }
    }
    
}
