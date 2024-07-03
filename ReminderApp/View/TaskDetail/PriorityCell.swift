//
//  PriorityCell.swift
//  ReminderApp
//
//  Created by 강한결 on 7/3/24.
//

import UIKit
import SnapKit

final class PriorityCell: BaseDetailCell {
    var sender: ((String) -> ())?
    private let priorities = Priority.allCases.map { $0.rawValue }
    private var priority = ""
    
    lazy var segment = UISegmentedControl(items: priorities)
    
    override func configureSubView() {
        super.configureSubView()
        super.back.addSubview(segment)
    }
    
    override func configureLayout() {
        super.configureLayout()
        segment.snp.makeConstraints {
            $0.top.equalTo(super.menu.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(super.back.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        super.configureView()
        super.label.text = "우선 순위"
        segment.backgroundColor = .systemGray
        segment.addTarget(self, action: #selector(segmenting), for: .valueChanged)
    }
    
    @objc
    func segmenting(_ seg: UISegmentedControl) {
        self.priority = self.priorities[seg.selectedSegmentIndex]
        sender?(self.priority)
    }

}
