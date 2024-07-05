//
//  TaskListViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import RealmSwift
import Toast

class TaskListViewController: BaseViewController {
    private var tasks: Results<Tasks>!
    private let taskRepository = Repository<Tasks>()
    
    private let mainView = TaskListView()
    
    override func loadView() {
        self.view = mainView

        configureTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNav(title: "", leftBarItem: genLeftWithGoBack(), rightBarItem: nil)
        mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    func configureViewWithData(_ data: CollectionItemInput) {
        let result = taskRepository.getRecords().output
        
        self.mainView.configureTitle(data.name, data.iconBackgroundColor)
        
        switch data.name {
        case "오늘":
            self.tasks = result?.where({ query in
                let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
                return (query.isCompleted == false) && (query.dueDate != nil) && (query.dueDate > yesterday) && (query.dueDate < tomorrow)
            })
        case "예정":
            self.tasks = result?.where({ query in
                return (query.isCompleted == false) && (query.dueDate != nil) && (query.dueDate > Date())
            })
        case "깃발 표시":
            self.tasks = result?.where({ query in
                return (query.isCompleted == false) && (query.isFlaged)
            })
        case "완료됨":
            self.tasks = result?.where({ query in
                return query.isCompleted
            })
        default:
            self.tasks = result?.where({ query in
                query.isCompleted == false
            })
        }
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        let t = self.mainView.table
        t.delegate = self
        t.dataSource = self
        t.register(TaskCell.self, forCellReuseIdentifier: TaskCell.id)
        t.rowHeight = UITableView.automaticDimension
        t.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.id, for: indexPath) as! TaskCell

        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(onTouchCompleteButton), for: .touchUpInside)
        cell.configureViewWithData(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, handler in
            let task = self.tasks[indexPath.row]
            let result = self.taskRepository.deleteSingleRecordById(id: task.id)
            
            if result.ok {
                self.view.makeToast("삭제 성공!", duration: 2)
                self.mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
            } else {
                self.view.makeToast(result.error)
            }
        }
        
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "xmark.circle")
        delete.image?.withTintColor(.white)
            
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = self.tasks[indexPath.row]
        let flaged = UIContextualAction(style: .normal, title: nil) { action, view, handler in
            let update = self.taskRepository.updateSingleRecordById(id: task.id) { task in
                task.isFlaged.toggle()
            }
            
            if update.ok {
                self.mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
            } else {
                self.view.makeToast(update.error)
            }
        }
        
        flaged.backgroundColor = task.isFlaged ? .white : .systemOrange
        flaged.image?.withTintColor(task.isFlaged ? .orange : .white)
        flaged.image = UIImage(systemName: "flag.fill")

        
        return UISwipeActionsConfiguration(actions: [flaged])
    }
}

extension TaskListViewController {
    @objc
    func onTouchCompleteButton(_ sender: UIButton) {
        let targetRecord = tasks[sender.tag]
        
        sender.configuration?.image = UIImage(systemName: "checkmark.circle")
        
        let update = taskRepository.updateSingleRecordById(id: targetRecord.id) { task in
            task.isCompleted = true
        }
        
        if update.ok {
            mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
        } else {
            view.makeToast(update.error)
        }
    }
}
