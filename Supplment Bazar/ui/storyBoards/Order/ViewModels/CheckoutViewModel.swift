//
//  CheckoutViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 18/07/2021.
//

import Foundation

struct CheckoutBody: Encodable {
    let first_name: String
    let last_name: String
    let province: String
    let address1: String
    let address2: String?
    let phone_number: String
    let phone_number2: String?
}

struct CheckoutResponse: Decodable {
    let order_number: String
}

class CheckoutViewModel: BaseViewModel {
    
    func checkout(body: CheckoutBody, result: @escaping (String?) -> ()) {
        self.view.startWaiting()
        NetworkEngine.makeRequestWithBody(url: CartUrl.checkout, method: .post, body: body) { (res: GenericAPIResponse<CheckoutResponse>?, err) in
            self.view.endWaiting()
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            result(res?.message)
        }
    }
}
