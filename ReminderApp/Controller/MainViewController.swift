//
//  ViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit

class MainViewController: BaseViewController {
    private var taskLists = TaskListModel
    
    private let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
    }
    
    override func configureAction() {
        mainView.addAction(object: mainView.addButton, target: self, action: #selector(showAddTaskVC), event: .touchUpInside)
    }
    
}

extension MainViewController {
    @objc
    func goTotalTaskLists() {
        goSomeVC(vc: TaskListViewController()) { vc in
            vc.configureViewWithData("전체", .systemGreen)
        }
    }
    
    @objc 
    func showAddTaskVC() {
        let vc = UINavigationController(rootViewController: AddTaskViewController())
        presentSomeVC(vc: vc) { _ in }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollection() {
        mainView.collection.delegate = self
        mainView.collection.dataSource = self
        mainView.collection.register(TaskCollectionItem.self, forCellWithReuseIdentifier: TaskCollectionItem.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionItem.id, for: indexPath) as? TaskCollectionItem else { return UICollectionViewCell() }
        
        item.configureViewWithData(taskLists[indexPath.row])
                
        return item
    }
    
    
}
