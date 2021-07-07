//
//  HomeViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import Foundation

class BaseViewModel: NSObject {

    var error: LiveData<String?> = LiveData(nil)

    required override init() {

    }

}

class HomeViewModel: BaseViewModel {
    
    func getHome(result: @escaping (HomeSections?) -> ()) {
        NetworkEngine.makeRequestWithBody(url: HomeURL.home, method: .get, body: Optional<Int>.none) { (res: GenericAPIResponse<HomeSections>?, err) in
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            result(res?.data)
        }
    }
    
    func getAllProducts(sectionId: String, result: @escaping (HomeSections?) -> ()) {
        let url = "\(HomeURL.viewAllProduct)\(sectionId)"
        NetworkEngine.makeRequestWithBody(url: url, method: .get, body: Optional<Int>.none) { (res: GenericAPIResponse<HomeSections>?, err) in
            if let err = err {
                self.error.value = err
                result(nil)
                return
            }
            result(res?.data)
        }
    }
    
}
