//
//  ViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit

final class MainViewController: BaseViewController {
    private var taskLists = TaskListModel
    private var taskListsCount = TaskListModel.map { _ in return 0 }
    private let taskRepository = Repository<Tasks>()
    
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
        let vc = AddTaskViewController()
        presentSomeVC(vc: UINavigationController(rootViewController: vc)) { _ in
            vc.sender = {
                self.mappingCollectionCount()
                self.mainView.collection.reloadData()
            }
        }
    }
    
    private func mappingCollectionCount() {
        [self.countByDueDate(.orderedSame), self.countByDueDate(.orderedDescending), self.countByCompletion(false), self.countByIsFlaged(), self.countByCompletion(true)].enumerated().forEach { (idx, value) in
            self.taskLists[idx].count = value
        }
    }
    
    private func countByDueDate(_ standard: ComparisonResult) -> Int {
        let result = self.taskRepository.getRecords().output
        
        guard let count = (result?.filter { !$0.isCompleted && $0.dueDate != nil }.filter {
            if let due = $0.dueDate {
                return Date.compareWithToday(due) == standard
            }
            return false
        }.count) else { return 0 }
        
        return count
    }
    
    private func countByCompletion(_ standard: Bool) -> Int {
        let result = self.taskRepository.getRecords().output
        
        guard let count = (result?.filter { $0.isCompleted == standard }.count) else { return 0}
        
        return count
    }
    
    private func countByIsFlaged() -> Int {
        let result = self.taskRepository.getRecords().output
        
        guard let count = (result?.filter { !$0.isCompleted && $0.isFlaged == true }.count) else { return 0}
        
        return count
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func configureCollection() {
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
