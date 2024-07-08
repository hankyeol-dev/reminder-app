//
//  TagTableCell.swift
//  ReminderApp
//
//  Created by 강한결 on 7/8/24.
//

import UIKit
import SnapKit

final class TagTableCell: UITableViewCell {
    private let back = UIView()
    private let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(back)
        back.addSubview(label)
        
        back.snp.makeConstraints {
            $0.verticalEdges.leading.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        label.snp.makeConstraints {
            $0.edges.equalTo(back.safeAreaLayoutGuide).inset(8)
        }
        
        back.layer.cornerRadius = 16
        back.layer.masksToBounds = true
        back.backgroundColor = [UIColor.systemBlue, UIColor.systemGreen, UIColor.systemMint, UIColor.systemPink, UIColor.systemPurple].randomElement()
        
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
    }
    
    func configureLabel(_ data: Tags) {
        label.text = " # " + data.name + " - " + "\(data.tasks.count)개"
    }
}
