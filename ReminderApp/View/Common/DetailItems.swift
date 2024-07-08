//
//  DetailItems.swift
//  ReminderApp
//
//  Created by 강한결 on 7/8/24.
//

import UIKit
import SnapKit

final class DetailItems: BaseView {
    private let back = UIView()
    private let label = UILabel()
    private let state = UILabel()
    
    convenience init(_ t: String) {
        self.init(frame: .zero)
        self.label.text = t
    }
    
    override func configureSubView() {
        self.addSubview(back)
        [label, state].forEach {
            back.addSubview($0)
        }
    }
    
    override func configureLayout() {
        back.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        label.snp.makeConstraints {
            $0.centerY.equalTo(back.snp.centerY)
            $0.leading.equalTo(back.safeAreaLayoutGuide).inset(16)
        }
        state.snp.makeConstraints {
            $0.centerY.equalTo(back.snp.centerY)
            $0.trailing.equalTo(back.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        back.backgroundColor = .systemGray4
        back.layer.cornerRadius = 8
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        state.textColor = .black
        state.font = .systemFont(ofSize: 14)
    }
    
    func configureState(_ t: String) {
        state.text = t
    }
}
