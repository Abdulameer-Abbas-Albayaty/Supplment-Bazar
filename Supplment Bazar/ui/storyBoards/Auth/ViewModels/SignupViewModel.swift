//
//  SignupViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/07/2021.
//

import Foundation

struct SignupRequestData: Encodable {
    let name: String
    let phone_number: String
    let password: String
    let password_confirmation: String
}

struct SignUpResponse: Decodable {
    let access_token: String
}

class SignupViewModel: BaseViewModel {
    
    func signup(body: SignupRequestData, result: @escaping (String?) -> Void) {
        NetworkEngine.makeRequestWithBody(url: AuthURL.signUp, method: .post, body: body) { (res: GenericAPIResponse<SignUpResponse>?, error)  in
            if let error = error {
                self.error.value = error
                result(nil)
                return
            }
            if let res = res {
                UserUD.token = res.data?.access_token
                result(res.message)
            }
        }
    }
}
