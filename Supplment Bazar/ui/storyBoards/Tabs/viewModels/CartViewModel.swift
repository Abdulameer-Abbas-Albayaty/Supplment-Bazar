//
//  CartViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 09/06/2021.
//

import Foundation

struct GetCartResponse: Decodable {
    let id: String
    let amount: String
    let price: String
    let quantity: Int
    let products: ProductResponse
}

class CartViewModel: BaseViewModel {
    
    var items = MutableLiveData<[GetCartResponse]?>()
    
    func getCart() {
        NetworkEngine.makeRequestWithBody(url: CartUrl.get, method: .get, body: Optional<Int>.none) { (res: GenericAPIResponse<[GetCartResponse]>?, err) in
            if let err = err {
                self.error.value = err
                self.items.property = nil
                return
            }
            self.items.property = res?.data
        }
    }
    
    func delete(id: String, result: @escaping (String?) -> ()) {
        let url = "\(CartUrl.delete)\(id)"
        NetworkEngine.makeRequestWithBody(url: url, method: .delete, body: Optional<Int>.none) { (res: GenericAPIResponse<[GetCartResponse]>?, err) in
            if let err = err {
                self.error.value = err
                self.items.property = nil
                return
            }
            self.items.property = res?.data
        }
    }
    
    func edit(id: String) {
        let url = "\(CartUrl.edit)\(id)/edit"
        NetworkEngine.makeRequestWithBody(url: url, method: .put, body: Optional<Int>.none) { (res: GenericAPIResponse<[GetCartResponse]>?, err) in
            if let err = err {
                self.error.value = err
                self.items.property = nil
                return
            }
            self.items.property = res?.data
        }
    }
    
}
