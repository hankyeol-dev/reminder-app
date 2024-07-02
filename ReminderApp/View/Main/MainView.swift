//
//  MainView.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    let goButton = UIButton() // 임시
    let addButton = UIButton()
    
    override func configureSubView() {
        self.addSubview(goButton)
        self.addSubview(addButton)
    }
    
    override func configureLayout() {
        goButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
    }
    
    override func configureView() {
        goButton.configuration = .filled()
        goButton.configuration?.title = "전체 보기"
        addButton.configuration = .addButtonImpl("새로운 할 일")
    }
}
