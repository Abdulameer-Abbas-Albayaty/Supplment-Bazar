////
////  CartDao.swift
////  Supplment Bazar
////
////  Created by Ameer on 06/06/2021.
////
//
//import Foundation
//import CoreData
//import UIKit
//
//class GenricCoreData<T: NSManagedObject> {
//    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    func fetchAll() -> [T]? {
//        let entityName = String(describing: T.self)
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        let data = try? context.fetch(fetchRequest) as? [T]
//        return data
//    }
//    
//    func deleteAll() {
//        let entityName = String(describing: T.self)
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        let request = NSBatchDeleteRequest(fetchRequest: fetch)
//        
//        do {
//            try context.execute(request)
//            try context.save()
//        } catch {
//            print ("There was an error")
//        }
//    }
//    
//}
//
//class CartDao: GenricCoreData<Cart> {
//    
//    func insert(data: ProductResponse, image: Data, quantity: Int, completion: @escaping (String?) -> Void) {
//        if !isProductExist(id: data.id) {
//            let cart = Cart(context: context)
//            cart.name = data.name
//            cart.id = data.id
//            cart.price = data.price
//            cart.image = image
//            cart.quantity = Int16(quantity)
//            
//            do {
//                try context.save()
//                completion(nil)
//            } catch {
//                completion("Error to save")
//            }
//        } else {
//            completion("This product already in cart list")
//        }
//    }
//    
//    func isProductExist(id: String) -> Bool {
//        do {
//            let fetchRequest : NSFetchRequest<Cart> = Cart.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
//            let fetchedResults = try context.fetch(fetchRequest) as [Cart]
//            if fetchedResults.count > 0 {
//                return true
//            }
//        } catch {
//            return false
//        }
//        return false
//    }
//    
//    func findById(id: String) -> Cart? {
//        do {
//            let fetchRequest : NSFetchRequest<Cart> = Cart.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
//            let fetchedResults = try context.fetch(fetchRequest) as [Cart]
//            if fetchedResults.count > 0 {
//                return fetchedResults[0]
//            }
//        } catch {
//            return nil
//        }
//        return nil
//    }
//    
//    func delete(id: String, result: @escaping (Bool) -> ()) {
//        if let cart = findById(id: id) {
//            context.delete(cart)
//            try? context.save()
//            result(true)
//        } else {
//            result(false)
//        }
//    }
//    
//    func changeQuantity(id: String, quantity: Int, completion: @escaping (Bool) -> ()) {
//        if let cart = findById(id: id) {
//            cart.quantity = Int16(quantity)
//            do {
//                try context.save()
//                completion(true)
//            } catch {
//                completion(false)
//            }
//        } else {
//            completion(false)
//        }
//    }
//    
//}
