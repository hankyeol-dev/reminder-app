//
//  TaskCell.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class TaskCell: UITableViewCell {
    private let back = UIView()
    private let taskStack = UIStackView()
    private let taskTitle = UILabel()
    private let taskMemo = UILabel()
    private let taskDue = UILabel()
    let button = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubView()
        configureLayout()
        configureView()
    }

    private func configureSubView() {
        contentView.addSubview(back)
        
        [button, taskStack].forEach {
            back.addSubview($0)
        }
        [taskTitle].forEach {
            taskStack.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        back.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
        }
        button.snp.makeConstraints {
            $0.top.equalTo(back.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(back.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(16)
        }
        taskStack.snp.makeConstraints {
            $0.top.equalTo(back.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(button.snp.trailing).offset(12)
            $0.trailing.equalTo(back.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(back.safeAreaLayoutGuide).inset(8)
        }
    }
    
    private func configureView() {
        back.backgroundColor = .systemGray5
        
        button.configuration = .borderless()
        button.configuration?.image = UIImage(systemName: "circle")
        button.configuration?.baseBackgroundColor = .white
        button.configuration?.baseForegroundColor = .darkGray
        
        taskStack.axis = .vertical
        taskStack.spacing = 4
        taskStack.distribution = .fillEqually
        taskStack.alignment = .top
        
        taskTitle.font = .systemFont(ofSize: 14)
    }
    
    func configureViewWithData(_ data: Tasks) {
        taskTitle.text = data.title
        
        if let memo = data.memo {
            taskStack.addArrangedSubview(taskMemo)
            taskMemo.text = memo
            taskMemo.font = .systemFont(ofSize: 12)
            taskMemo.textColor = .black
        }
        
        if let due = data.dueDate {
            taskStack.addArrangedSubview(taskDue)
            taskDue.text = due.formatted()
            taskDue.font = .systemFont(ofSize: 10)
            taskDue.textColor = .systemGray3
        }
        
    }
}
