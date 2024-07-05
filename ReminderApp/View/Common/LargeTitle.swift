//
//  LargeTitle.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class LargeTitle: BaseView {
    private let label = UILabel()
    
    override func configureSubView() {
        self.addSubview(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        label.textColor = .systemGreen
        label.font = .boldSystemFont(ofSize: 24)
    }
    
    func setTitle(_ t: String, _ c: UIColor) {
        label.text = t
        label.textColor = c
    }
}
