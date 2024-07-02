//
//  Divider.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

class Divider: BaseView {
    private let line = UIView()
    
    override func configureSubView() {
        self.addSubview(line)
    }
        
    override func configureLayout() {
        line.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.systemGray6.cgColor
    }
}
