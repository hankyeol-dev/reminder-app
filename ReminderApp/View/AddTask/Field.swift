//
//  Field.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class Field: BaseView {
    private let back = UIView()
    private let divider = Divider()
    let titleField = UITextField()
    let memoField = UITextView()
    
    override func configureSubView() {
        self.addSubview(back)
        [titleField, divider, memoField].forEach {
            back.addSubview($0)
        }
    }
    
    override func configureLayout() {
        back.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        titleField.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(back.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(44)
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(back.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(1)
        }
        memoField.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(4)
            $0.bottom.horizontalEdges.equalTo(back.safeAreaLayoutGuide).inset(8)
        }
    }
    
    override func configureView() {
        back.layer.cornerRadius = 8
        back.backgroundColor = .systemGray4
        
        titleField.backgroundColor = .none
        titleField.placeholder = "제목"
        titleField.textColor = .black
        titleField.font = .systemFont(ofSize: 13)
        titleField.leftView = UIView(frame: CGRect(x: 4, y: 4, width: 6, height: 44))
        titleField.leftViewMode = .always
        
        memoField.backgroundColor = .none
        memoField.font = .systemFont(ofSize: 13)
    }
    
    func configureMemoFieldInit() {
        memoField.text = "메모"
        memoField.textColor = .systemGray2
    }
    
    func configureMemoFieldBegin() {
        memoField.text = nil
        memoField.textColor = .black
    }
}
