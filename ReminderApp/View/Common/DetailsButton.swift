//
//  DetailsButton.swift
//  ReminderApp
//
//  Created by 강한결 on 7/3/24.
//

import UIKit
import SnapKit

class DetailsButton: BaseView {
    private let back = UIView()
    private let label = UILabel()
    private let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
    let button = UIButton()
    
    convenience init(_ t: String) {
        self.init(frame: .zero)
        self.label.text = t
    }
    
    override func configureSubView() {
        self.addSubview(back)
        [label, arrow, button].forEach {
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
        arrow.snp.makeConstraints {
            $0.centerY.equalTo(back.snp.centerY)
            $0.trailing.equalTo(back.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(12)
        }
        button.snp.makeConstraints {
            $0.edges.equalTo(back.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        back.backgroundColor = .systemGray4
        back.layer.cornerRadius = 8
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        arrow.tintColor = .black
    }
}
