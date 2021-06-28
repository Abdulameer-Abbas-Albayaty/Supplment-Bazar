//
//  CartViewModel.swift
//  Supplment Bazar
//
//  Created by Ameer on 09/06/2021.
//

import Foundation

class CartViewModel: BaseViewModel {
    
    fileprivate let coreData = CartDao()
    var items = LiveData<[Cart]>([])
    var totalAmount : Double {
        get {
            calculateAmount()
        }
    }
    
    required init() {
        super.init()
        
        self.items.value = coreData.fetchAll() ?? []
    }
    
    fileprivate func calculateAmount() -> Double {
        var amount = Double()
        items.value.forEach { (cart) in
            amount += (cart.price * Double(cart.quantity))
        }
        return amount
    }
    
    func deleteItem(id: String) {
        coreData.delete(id: id) { (sucess) in
            if sucess {
                self.items.value = self.coreData.fetchAll() ?? []
            }
        }
    }
    
    func changeQuantity(id: String, quantity: Int) {
        coreData.changeQuantity(id: id, quantity: quantity) { (success) in
            if success {
                self.items.value = self.coreData.fetchAll() ?? []
            } else {
                print("error")
            }
        }
    }
    
}
