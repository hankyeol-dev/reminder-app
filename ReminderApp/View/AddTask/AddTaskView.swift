//
//  AddTaskView.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

class AddTaskView: BaseView {
    let header = Header()
    let field = Field()
    
    override func configureSubView() {
        [header, field].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        header.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        field.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(240)
        }
    }
}
