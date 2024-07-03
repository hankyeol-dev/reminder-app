//
//  DuedateCell.swift
//  ReminderApp
//
//  Created by 강한결 on 7/3/24.
//

import UIKit
import SnapKit

final class DuedateCell: BaseDetailCell {
    var sender: ((Date) -> ())?
    private let picker = UIDatePicker()
    
    override func configureSubView() {
        super.configureSubView()
        super.back.addSubview(picker)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        picker.snp.makeConstraints {
            $0.top.equalTo(super.menu.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(super.back.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        super.configureView()
        super.label.text = "마감일 지정"
        
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko-KR")
        picker.preferredDatePickerStyle = .inline
        picker.addTarget(self, action: #selector(pickDate), for: .valueChanged)
    }
    
    @objc
    func pickDate(_ sender: UIDatePicker) {
        super.subLabel.text = dateFormatter(sender.date)
        self.sender?(sender.date)
    }
    
    private func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        
        return formatter.string(from: date)
    }
}
