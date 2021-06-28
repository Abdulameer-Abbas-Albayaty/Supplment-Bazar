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

class ProductDetailsViewModel: BaseViewModel {
    
    fileprivate let coreData = CartDao()
        
    func insertToCart(data: ProductResponse, image: Data, quantity: Int, result: @escaping (String?) -> Void) {
        coreData.insert(data: data, image: image, quantity: quantity) { (err) in
            if let err = err {
                self.error.value = err
                result(nil)
                return
            } else {
                result("Item has been added successfully")
            }
        }
    }
    
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
    
}
