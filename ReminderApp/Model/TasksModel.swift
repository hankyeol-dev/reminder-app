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

/**
 - 하나의 Task는 여러 개의 Tag를 가질 수 있다. <-> 하나의 Tag는 여러 개의 Task를 가질 수 있다. (다 대 다)
 - 하나의 Task는 하나의 Priority를 가질 수 있다. <-> 하나의 Priority는 여러 Task를 가질 수 있다. (단, 꼭 테이블일 필요는 없다.)
 */

final class Tasks: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var dueDate: Date?
    @Persisted var priority: String?
    @Persisted var isCompleted: Bool
    @Persisted var isFlaged: Bool
    @Persisted var createdAt: Date = Date()
    @Persisted var updatedAt: Date = Date()
    
    @Persisted var tags: List<Tags>
    @Persisted(originProperty: "tasks") var link: LinkingObjects<Tags>
    
    convenience init(title: String, memo: String? = nil, dueDate: Date? = nil, priority: String? = nil, isCompleted: Bool = false, isFlaged: Bool = false) {
        self.init()
        
        self.title = title
        self.memo = memo
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
        self.isFlaged = isFlaged
    }
}
