//
//  MainView.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    let addButton = UIButton()
    
    override func configureSubView() {
        self.addSubview(addButton)
    }
    
    override func configureLayout() {
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
    }
    
    override func configureView() {
        addButton.configuration = .addButtonImpl("새로운 할 일")
    }
}
