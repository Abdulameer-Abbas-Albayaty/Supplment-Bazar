//
//  DynamicValue.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/23/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import Foundation

class LiveData<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observer(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
