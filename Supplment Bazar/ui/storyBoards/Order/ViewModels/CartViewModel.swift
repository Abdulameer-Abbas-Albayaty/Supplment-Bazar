//
//  CartViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 09/06/2021.
//

import Foundation

struct GetCartResponse: Decodable {
    let items: [CartData]
    let total_cart_price: String
}

struct CartData: Decodable {
    let id: String
    let amount: String
    let price: String
    let quantity: Int
    let products: ProductResponse
    let options: OptionData
}

struct OptionData: Decodable {
    let flavor: String
    let size: String
}

struct ChangeQuantityBody: Encodable {
    let quantity: Int
}

class CartViewModel: BaseViewModel {
    
    var items = MutableLiveData<GetCartResponse?>()
    
    func getCart() {
        self.view.startWaiting()
        NetworkEngine.makeRequestWithBody(url: CartUrl.get, method: .get, body: Optional<Int>.none) { (res: GenericAPIResponse<GetCartResponse>?, err) in
            self.view.endWaiting()
            if let err = err {
                self.error.value = err
                self.items.property = nil
                return
            }
            self.items.property = res?.data
        }
    }
    
    func delete(id: String) {
        self.view.startWaiting()
        let url = "\(CartUrl.delete)\(id)"
        NetworkEngine.makeRequestWithBody(url: url, method: .delete, body: Optional<Int>.none) { (res: GenericAPIResponse<GetCartResponse>?, err) in
            self.view.endWaiting()
            if let err = err {
                self.error.value = err
                self.items.property = nil
                return
            }
            self.items.property = res?.data
        }
    }
    
    func edit(id: String, body: ChangeQuantityBody) {
        let url = "\(CartUrl.edit)\(id)/edit"
        self.view.startWaiting()
        NetworkEngine.makeRequestWithBody(url: url, method: .put, body: body) { (res: GenericAPIResponse<GetCartResponse>?, err) in
            self.view.endWaiting()
            if let err = err {
                self.error.value = err
                self.items.property = nil
                return
            }
            self.items.property = res?.data
        }
    }
    
}
