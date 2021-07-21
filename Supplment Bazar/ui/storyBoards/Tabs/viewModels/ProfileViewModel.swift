//
//  ProfileViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 08/07/2021.
//

import Foundation

class ProfileViewModel: BaseViewModel {
    
    func logout(result: @escaping (String?) -> ()) {
        NetworkEngine.makeRequestWithBody(url: AuthURL.logout, method: .post, body: Optional<Int>.none) { (res: GenericAPIResponse<String>?, err) in
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            result(res?.message)
        }
    }
}
