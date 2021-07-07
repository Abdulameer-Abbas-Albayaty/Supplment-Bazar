//
//  BrandsViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 29/06/2021.
//

import Foundation

class BrandsViewModel: BaseViewModel {
    
    func getBrands(page:Int, result: @escaping (GenericMetaAPIResponse<[ProductResponse]>?) -> ()) {
        let url = "\(HomeURL.allBrands)?page=\(page)"
        NetworkEngine.makeMetaRequestWithBody(url: url, method: .get, body: Optional<Int>.none) { (res: GenericMetaAPIResponse<[ProductResponse]>?, err) in
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            result(res)
        }
    }
    
}
