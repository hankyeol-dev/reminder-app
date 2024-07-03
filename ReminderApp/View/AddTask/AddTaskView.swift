//
//  AddTaskView.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

class AddTaskView: BaseView {
    let field = Field()
    let goDetail = DetailsButton("세부사항")
    
    override func configureSubView() {
        [field, goDetail].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        field.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(240)
        }
        
        goDetail.snp.makeConstraints {
            $0.top.equalTo(field.snp.bottom)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(80)
        }
    }
}
