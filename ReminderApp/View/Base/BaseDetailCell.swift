//
//  BaseDetailCell.swift
//  ReminderApp
//
//  Created by 강한결 on 7/3/24.
//

import UIKit
import SnapKit

class BaseDetailCell: UITableViewCell {
    let back = UIView()
    let menu = UIView()
    let label = UILabel()
    let subLabel = UILabel()
    
    @available(*, unavailable)
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
        contentView.addSubview(back)
        [menu].forEach {
            back.addSubview($0)
        }
        [label, subLabel].forEach {
            menu.addSubview($0)
        }
    }
    
    func configureLayout() {
        back.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        menu.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(back.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(44)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalTo(menu.snp.centerY)
            $0.leading.equalTo(menu.safeAreaLayoutGuide).inset(8)
        }
        
        subLabel.snp.makeConstraints {
            $0.centerY.equalTo(menu.snp.centerY)
            $0.trailing.equalTo(menu.safeAreaLayoutGuide).inset(8)
        }
    }
    
    func configureView() {
        back.backgroundColor = .systemGray6
        back.layer.cornerRadius = 8
    }
    
}

