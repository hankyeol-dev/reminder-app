//
//  Observable.swift
//  ReminderApp
//
//  Created by 강한결 on 7/9/24.
//

import Foundation

final class Observable<T> {
    private var handler: ((T) -> ())?
    
    var value: T {
        didSet {
            self.handler?(self.value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ value: T, handler: @escaping (T) -> ()) {
        handler(value)
        self.handler = handler
    }
}
