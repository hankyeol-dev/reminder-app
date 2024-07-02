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
    
    private let mainView = TaskListView()
    
    override func loadView() {
        self.view = mainView
        
        mainView.setLargeTitle("전체")
        configureTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let db = try Realm()
            self.tasks = db.objects(Tasks.self)
        } catch {
            mainView.makeToast("할 일을 불러오는데 실패했어요 ㅠㅠ :(")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        let t = self.mainView.table
        t.delegate = self
        t.dataSource = self
        t.register(TaskCell.self, forCellReuseIdentifier: TaskCell.id)
        t.rowHeight = 60
        t.separatorInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.id, for: indexPath) as! TaskCell

        cell.taskTitle.text = data.title
        
        if let memo = data.memo {
            cell.taskMemo.text = memo
        }
        
        if let dueDate = data.dueDate {
            cell.taskDue.text = dueDate.formatted()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, handler in
            let task = self.tasks[indexPath.row]
            do {
                let db = try Realm()
                try db.write {
                    db.delete(task)
                }
                self.mainView.table.reloadSections(IndexSet(integer: 0), with: .none)
            } catch {
                self.mainView.makeToast("히이잉 :(", duration: 5, position: .bottom)
            }
        }
        
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "xmark.circle")
        delete.image?.withTintColor(.white)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
