//
//  StoresViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 18/07/2021.
//

import Foundation

class StoresViewModel: BaseViewModel {
    
    let dataObserver = MutableLiveData<GenericMetaAPIResponse<[ProductResponse]>?>()
    
    func get(page:Int) {
        NetworkEngine.makeMetaRequestWithBody(url: HomeURL.allStores, method: .get, body: Optional<Int>.none) { (res: GenericMetaAPIResponse<[ProductResponse]>?, err) in
            if let err = err {
                self.error.value = err
                self.dataObserver.property = nil
                return
            }
            self.dataObserver.property = res
        }
    }
    
}
