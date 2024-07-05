//
//  TagsModel.swift
//  ReminderApp
//
//  Created by 강한결 on 7/4/24.
//

import Foundation
import RealmSwift

final class Tags: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    
    @Persisted var tasks: List<Tasks>
     @Persisted(originProperty: "tags") var link: LinkingObjects<Tasks>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
