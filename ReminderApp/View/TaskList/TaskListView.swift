//
//  TaskListView.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class TaskListView: BaseView {
    private let largeTitle = LargeTitle()
    let table = UITableView()
    
    override func configureSubView() {
        [largeTitle, table].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        largeTitle.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        table.snp.makeConstraints {
            $0.top.equalTo(largeTitle.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func configureTitle(_ t: String, _ c: UIColor) {
        largeTitle.setTitle(t, c)
    }
}

