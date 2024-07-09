//
//  AddTaskViewModel.swift
//  ReminderApp
//
//  Created by 강한결 on 7/9/24.
//

import Foundation

final class AddTaskViewModel {
    var dueInput = Observable<Date?>(nil)
    var priorityInput = Observable<String>("")
    var tagInput = Observable<String>("")
    var isFlagInput = Observable(false)
    
    var stateOuput = Observable<[String]>([])
    
    init() {
        dueInput.bind(nil) { _ in
            self.mapState()
        }
        priorityInput.bind("") { _ in
            self.mapState()
        }
        tagInput.bind("") { _ in
            self.mapState()
        }
        isFlagInput.bind(false) { _ in
            self.mapState()
        }
    }
    
    private func mapState() {
        self.stateOuput.value = []
        if let due = self.dueInput.value {
            self.stateOuput.value.append(Date.formattedDate(due))
        } else {
            self.stateOuput.value.append("")
        }
        
        if self.priorityInput.value != "" && self.priorityInput.value != "없음" {
            self.stateOuput.value.append(self.priorityInput.value)
        } else {
            self.stateOuput.value.append("")
        }
        
        if self.tagInput.value != "" {
            self.stateOuput.value.append(self.tagInput.value)
        } else {
            self.stateOuput.value.append("")
        }
        
        if self.isFlagInput.value {
            self.stateOuput.value.append("깃발 표시됨")
        } else {
            self.stateOuput.value.append("")
        }
    }
}
