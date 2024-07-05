//
//  MainView.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    private let largeTitle = LargeTitle()
    let collection = {
        let layout = UICollectionViewFlowLayout()
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let width = (window.screen.bounds.width - 48) / 2

        
        layout.itemSize = CGSize(width: width, height: width * 0.6)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    let goButton = UIButton() // 임시
    let addButton = UIButton()
    
    override func configureSubView() {
        self.addSubview(largeTitle)
        self.addSubview(collection)
        self.addSubview(addButton)
    }
    
    override func configureLayout() {
        largeTitle.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        collection.snp.makeConstraints {
            $0.top.equalTo(largeTitle.snp.bottom)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(120)
        }
        
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
    }
    
    override func configureView() {
        largeTitle.setTitle("전체", .systemGray3)
        goButton.configuration = .filled()
        goButton.configuration?.title = "전체 보기"
        addButton.configuration = .addButtonImpl("새로운 할 일")
    }
}
