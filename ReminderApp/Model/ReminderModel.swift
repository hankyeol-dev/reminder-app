//
//  ReminderModel.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//
import Foundation
import RealmSwift

enum Priority {
    case high, middle, row, none
}

class Tasks: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var dueDate: Date?
    @Persisted var createdAt: Date = Date()
    @Persisted var updatedAt: Date = Date()
    //    @Persisted var priority: Priority?
    
    convenience init(title: String, memo: String? = nil, dueDate: Date? = nil) {
        self.init()
        self.title = title
        self.memo = memo
        self.dueDate = dueDate
    }
}
