//
//  ReminderModel.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//
import Foundation
import RealmSwift

enum Priority: String, CaseIterable {
    case none = "없음"
    case row = "낮음"
    case middle = "중간"
    case high = "높음"
}

final class Tasks: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var dueDate: Date?
    @Persisted var createdAt: Date = Date()
    @Persisted var updatedAt: Date = Date()
    @Persisted var isCompleted: Bool = false
    @Persisted var isFlaged: Bool = false
    
    convenience init(title: String, memo: String? = nil, dueDate: Date? = nil) {
        self.init()
        self.title = title
        self.memo = memo
        self.dueDate = dueDate
    }
}

final class Tags: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
