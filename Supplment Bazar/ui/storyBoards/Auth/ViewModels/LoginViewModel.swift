//
//  LoginViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/07/2021.
//

import Foundation

struct LoginRequestData: Encodable {
    let phone_number: String
    let password: String
}

struct LoginResponse: Decodable {
    let access_token: String
    let is_verified: Bool
}

class LoginViewModel: BaseViewModel {
    
    func login(body: LoginRequestData, result: @escaping (LoginResponse?) -> Void) {
        NetworkEngine.makeRequestWithBody(url: AuthURL.login, method: .post, body: body) { (res: GenericAPIResponse<LoginResponse>?, error) in
            if let error = error {
                self.error.value = error
                result(nil)
                return
            }
            if let res = res {
                UserUD.token = res.data?.access_token
                if ((res.data?.is_verified) != nil) {
                    UserUD.isLogin = true
                }
                result(res.data)
            }
        }
    }
}
