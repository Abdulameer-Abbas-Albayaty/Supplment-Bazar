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

class MutableLiveData<T> {
    typealias Observe = (T) -> Void
    private var observe : Observe?
    private let thread : DispatchQueue

    var property : T? {
        willSet {
            if let value = newValue {
                thread.async {
                    self.observe?(value)
                }
            }
        }
    }

    func observe(observer: Observe?) {
        self.observe = observer
    }

    init(_ value: T? = nil, thread dispatcherThread: DispatchQueue = .main) {
        self.thread = dispatcherThread
        self.property = value
    }
}
