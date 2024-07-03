//
//  TaskDetailView.swift
//  ReminderApp
//
//  Created by 강한결 on 7/3/24.
//

import UIKit
import SnapKit

class TaskDetailView: BaseView {
    let table = UITableView()
    
    override func configureSubView() {
        self.addSubview(table)
    }
    
    override func configureLayout() {
        table.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
}
