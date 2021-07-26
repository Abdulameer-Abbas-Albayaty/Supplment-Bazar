//
//  ChangeViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 25/07/2021.
//

import Foundation

struct ChangePasswordRequest: Encodable {
    let current_password: String
    let password: String
    let password_confirmation: String
}

struct ChangePasswordResponse: Decodable {
    let access_token: String
}

class ChangePasswordViewModel: BaseViewModel {
    
    func change(body: ChangePasswordRequest, result: @escaping (String?) -> ()) {
        self.view.startWaiting()
        NetworkEngine.makeRequestWithBody(url: AuthURL.changePassword, method: .put, body: body) { (res:GenericAPIResponse<ChangePasswordResponse>?, err) in
            self.view.endWaiting()
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            UserUD.token = res?.data?.access_token
            result(res?.message)
        }
    }
}
