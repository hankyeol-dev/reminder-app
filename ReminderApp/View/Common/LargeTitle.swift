//
//  LargeTitle.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class LargeTitle: BaseView {
    private let back = UIView()
    let label = UILabel()
    
    override func configureSubView() {
        self.addSubview(back)
        back.addSubview(label)
    }
    
    override func configureLayout() {
        back.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        label.snp.makeConstraints {
            $0.centerY.equalTo(back.snp.centerY)
            $0.leading.equalTo(back.safeAreaLayoutGuide).inset(12)
        }
    }
    
    override func configureView() {
        label.textColor = .systemGreen
        label.font = .boldSystemFont(ofSize: 20)
    }
}
