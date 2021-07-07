//
//  VerifySignUpViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/07/2021.
//

import Foundation

struct VerifySignUpRequest: Encodable {
    let code: String
}

class VerifySignUpViewModel: BaseViewModel {
    
    func signup(body: VerifySignUpRequest, result: @escaping (String?) -> Void) {
        NetworkEngine.makeRequestWithBody(url: AuthURL.verifyOTP, method: .post, body: body) { (res: GenericAPIResponse<String>?, error)  in
            if let error = error {
                self.error.value = error
                result(nil)
                return
            }
            if let res = res {
                result(res.message)
            }
        }
    }
}
