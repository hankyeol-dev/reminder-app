//
//  TaskCell.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

// checkmark.circle.fill
// circle

final class TaskCell: UITableViewCell {
    let button = UIButton()
    let taskStack = UIStackView()
    let taskTitle = UILabel()
    let taskMemo = UILabel()
    let taskDue = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubView()
        configureLayout()
        configureView()
    }

    func configureSubView() {
        [button, taskStack].forEach {
            contentView.addSubview($0)
        }
        [taskTitle, taskMemo, taskDue].forEach {
            taskStack.addArrangedSubview($0)
        }
    }
    
    func configureLayout() {
        button.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(24)
        }
        taskStack.snp.makeConstraints {
            $0.leading.equalTo(button.snp.trailing).offset(12)
            $0.verticalEdges.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(4)
        }
    }
    
    func configureView() {
        button.configuration = .borderless()
        button.configuration?.image = UIImage(systemName: "circle")
        button.configuration?.baseBackgroundColor = .white
        button.configuration?.baseForegroundColor = .darkGray
        
        taskStack.axis = .vertical
        taskStack.spacing = 4
        taskStack.distribution = .fillEqually
        taskStack.alignment = .top
        
        taskTitle.font = .systemFont(ofSize: 14)
        taskMemo.font = .systemFont(ofSize: 10)
        taskMemo.textColor = .systemGray3
        taskDue.font = .systemFont(ofSize: 10)
        taskDue.textColor = .systemGray3
    }
    
}
