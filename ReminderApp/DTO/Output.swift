//
//  DefaultOutput.swift
//  ReminderApp
//
//  Created by 강한결 on 7/4/24.
//

import Foundation
import RealmSwift

final class Output<T> {
    var ok: Bool
    var error: String?
    var output: T?
    
    init(ok: Bool, error: String?, output: T?) {
        self.ok = ok
        self.error = error
        self.output = output
    }
}
