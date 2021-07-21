//
//  ProductViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 30/06/2021.
//

import Foundation

class ProductViewModel: BaseViewModel {
    
    let dataObserver = MutableLiveData<GenericMetaAPIResponse<[ProductResponse]>?>()
    
    func getBySectionId(page:Int, sectionId: String) {
        let url = "\(HomeURL.viewAllProduct)\(sectionId)?page=\(page)"
        NetworkEngine.makeMetaRequestWithBody(url: url, method: .get, body: Optional<Int>.none) { (res: GenericMetaAPIResponse<[ProductResponse]>?, err) in
            if let err = err {
                self.error.value = err
                self.dataObserver.property = nil
                return
            }
            self.dataObserver.property = res
        }
    }
    
    func getByCategory(page:Int, categoryId: String) {
        let url = "\(HomeURL.categoryDetails)\(categoryId)?page=\(page)"
        NetworkEngine.makeMetaRequestWithBody(url: url, method: .get, body: Optional<Int>.none) { (res: GenericMetaAPIResponse<[ProductResponse]>?, err) in
            if let err = err {
                self.error.value = err
                self.dataObserver.property = nil
                return
            }
            self.dataObserver.property = res
        }
    }
    
    func getByBrand(page:Int, brandId: String) {
        let url = "\(HomeURL.brandDetails)\(brandId)?page=\(page)"
        NetworkEngine.makeMetaRequestWithBody(url: url, method: .get, body: Optional<Int>.none) { (res: GenericMetaAPIResponse<[ProductResponse]>?, err) in
            if let err = err {
                self.error.value = err
                self.dataObserver.property = nil
                return
            }
            self.dataObserver.property = res
        }
    }
    
    func getByStore(page:Int, storeId: String) {
        let url = "\(StoreURL.getStoreDetails)\(storeId)?page=\(page)"
        NetworkEngine.makeMetaRequestWithBody(url: url, method: .get, body: Optional<Int>.none) { (res: GenericMetaAPIResponse<[ProductResponse]>?, err) in
            if let err = err {
                self.error.value = err
                self.dataObserver.property = nil
                return
            }
            self.dataObserver.property = res
        }
    }
    
}
