//
//  HomeViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import UIKit

class BaseViewModel {

    var error: LiveData<String?> = LiveData(nil)
    var view: UIViewController!

    required init(v: UIViewController) {
        self.view = v
    }

}

class HomeViewModel: BaseViewModel {
    
    func getHome(result: @escaping (HomeSections) -> ()) {
        self.view.startWaiting()
        NetworkEngine.makeRequestWithBody(url: HomeURL.home, method: .get, body: Optional<Int>.none) { (res: GenericAPIResponse<HomeSections>?, err) in
            self.view.endWaiting()
            if let err = err {
                self.error.value = err
                return
            }
            if let data = res?.data {
                result(data)
            }
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
