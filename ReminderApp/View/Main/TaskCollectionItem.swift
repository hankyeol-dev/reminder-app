//
//  TaskCollectionItem.swift
//  ReminderApp
//
//  Created by 강한결 on 7/4/24.
//

import UIKit
import SnapKit

final class TaskCollectionItem: UICollectionViewCell {
    let iconBack = UIView()
    let icon = UIImageView()
    let count = UILabel()
    let name = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        let guide = contentView.safeAreaLayoutGuide
        [iconBack, count, name].forEach {
            contentView.addSubview($0)
        }
        iconBack.addSubview(icon)
        
        iconBack.snp.makeConstraints {
            $0.top.leading.equalTo(guide).inset(16)
            $0.size.equalTo(32)
        }
        icon.snp.makeConstraints {
            $0.edges.equalTo(iconBack.safeAreaLayoutGuide).inset(6)
        }
        count.snp.makeConstraints {
            $0.top.trailing.equalTo(guide).inset(16)
            $0.centerY.equalTo(iconBack.snp.centerY)
        }
        name.snp.makeConstraints {
            $0.top.equalTo(icon.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(guide).inset(16)
        }
        
        
        contentView.layer.cornerRadius = 8
        iconBack.layer.cornerRadius = 16
        count.font = .boldSystemFont(ofSize: 24)
        name.font = .systemFont(ofSize: 18)
        name.textColor = .darkGray
    }
    
    func configureViewWithData(_ data: CollectionItemInput) {
        contentView.backgroundColor = data.itemBackgroundColor
        iconBack.backgroundColor = data.iconBackgroundColor
        icon.image = data.icon
        icon.tintColor = data.iconColor
        count.text = String(data.count)
        name.text = data.name
    }
    
}
