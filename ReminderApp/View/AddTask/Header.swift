//
//  Header.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class Header: BaseView {
    private let stack = UIStackView()
    private let titleLabel = UILabel()
    let cancelButton = UIButton()
    let saveButton = UIButton()
    
    override func configureSubView() {
        [stack].forEach {
            self.addSubview($0)
        }
        
        [cancelButton, titleLabel, saveButton].forEach {
            stack.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        stack.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(stack.snp.centerY)
            $0.leading.equalTo(stack.safeAreaLayoutGuide)
            $0.width.equalTo(60)
        }
        saveButton.snp.makeConstraints {
            $0.centerY.equalTo(stack.snp.centerY)
            $0.trailing.equalTo(stack.safeAreaLayoutGuide)
            $0.width.equalTo(60)
        }
        titleLabel.snp.makeConstraints {
            $0.center.equalTo(stack.snp.center)
        }
    }
    
    override func configureView() {
        stack.axis = .horizontal
        stack.alignment = .center
        
        cancelButton.configuration = .borderless()
        cancelButton.configuration?.title = "취소"
        saveButton.configuration = .borderless()
        saveButton.configuration?.title = "저장"
        
        titleLabel.text = "새로운 할 일"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 16)
    }
    
    func saveButtonConfiguration(_ isEnabled: Bool) {
        if isEnabled {
            saveButton.isEnabled = true
            saveButton.configuration?.baseForegroundColor = .systemGreen
        } else {
            saveButton.isEnabled = false
            saveButton.configuration?.baseForegroundColor = .lightGray
        }
    }
    

}
