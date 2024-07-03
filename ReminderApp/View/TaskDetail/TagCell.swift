//
//  TagCell.swift
//  ReminderApp
//
//  Created by 강한결 on 7/3/24.
//

import UIKit
import SnapKit

final class TagCell: BaseDetailCell {
    var sender: ((String) -> ())?
    private var tags = "" {
        didSet {
            sender?(self.tags)
        }
    }
    
    private let field = UITextField()
    
    override func configureSubView() {
        super.configureSubView()
        super.back.addSubview(field)
    }
    
    override func configureLayout() {
        super.configureLayout()
        field.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.equalTo(super.menu.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(super.back.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(super.back.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        super.configureView()
        super.label.text = "태그"
        field.delegate = self
        
        field.placeholder = "태그를 입력해보세요."
        field.backgroundColor = .systemGray5
        field.leftView = UIView(frame: CGRect(x: 1, y: 1, width: 4, height: 4))
        field.leftViewMode = .always
    }
}

extension TagCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.tags = text
        super.subLabel.text = text
    }
}
