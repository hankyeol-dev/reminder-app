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
    
    private let states = [DetailItems("마감일"), DetailItems("우선순위"), DetailItems("태그"), DetailItems("깃발표시")]
    
    override func configureSubView() {
        [field, goDetail].forEach {
            self.addSubview($0)
        }
        states.forEach {
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
        
        self.states.enumerated().forEach { (idx, obj) in
            obj.snp.makeConstraints {
                if idx == 0 {
                    $0.top.equalTo(goDetail.snp.bottom)
                } else {
                    $0.top.equalTo(states[idx - 1].snp.bottom)
                }
                $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
                $0.height.equalTo(60)
            }
        }
    }
    
    func configureViewWithData(_ data: [String]) {
        data.enumerated().forEach { (idx, v) in
            self.states[idx].configureState(v)
        }
    }
}
