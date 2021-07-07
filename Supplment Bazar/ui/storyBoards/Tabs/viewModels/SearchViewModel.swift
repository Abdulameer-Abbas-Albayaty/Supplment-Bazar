//
//  SearchViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import Foundation

class SearchRepo {
    
    static func get(query: String,result: @escaping ([ProductResponse]?, String?) -> ()) {
        let url = "\(HomeURL.search)?q=\(query)"
        NetworkEngine.makeRequestWithBody(url: url, method: .get, body: Optional<Int>.none) { (res: GenericAPIResponse<[ProductResponse]>?, error) in
            result(res?.data, error)
        }
    }
}

class SearchViewModel: BaseViewModel {
    
    func get(query: String,result: @escaping ([ProductResponse]?) -> ()) {
        SearchRepo.get(query: query) { (res, err) in
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            result(res)
        }
    }
}
