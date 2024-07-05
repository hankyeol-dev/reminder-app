//
//  FlagCell.swift
//  ReminderApp
//
//  Created by 강한결 on 7/5/24.
//

import UIKit
import SnapKit

final class FlagCell: BaseDetailCell {
    var sender: ((Bool) -> ())?

    private let toggle = UISwitch()
    private var isOn = false {
        didSet {
            sender?(self.isOn)
        }
    }
    
    override func configureSubView() {
        super.configureSubView()
        super.back.addSubview(toggle)
    }
    
    override func configureLayout() {
        super.configureLayout()
        toggle.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.equalTo(super.menu.snp.bottom).offset(8)
            $0.leading.equalTo(super.back.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(super.back.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        super.configureView()
        super.label.text = "깃발 표시"
        toggle.addTarget(self, action: #selector(toggling), for: .valueChanged)
    }
    
    @objc
    func toggling() {
        isOn.toggle()
    }
}
