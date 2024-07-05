//
//  TaskDetailViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/3/24.
//

import UIKit

final class TaskDetailViewController: BaseViewController {
    var sender: (() -> ())?
    var due: Date?
    var priority: String = ""
    var tags: String = ""
    var isFlaged: Bool = false
    
    private let cells = [DuedateCell.self, PriorityCell.self, TagCell.self, FlagCell.self]
    private let mainView = TaskDetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav(title: "세부사항", leftBarItem: genLeftWithGoBack(), rightBarItem: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sender?()
    }
}

extension TaskDetailViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        let table = mainView.table
        
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        
        cells.forEach {
            table.register($0, forCellReuseIdentifier: $0.id)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DuedateCell.id, for: indexPath) as! DuedateCell
            cell.sender = { due in
                self.due = due
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PriorityCell.id, for: indexPath) as! PriorityCell
            cell.sender = { priority in self.priority = priority }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.id, for: indexPath) as! TagCell
            cell.sender = { tags in self.tags = tags }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: FlagCell.id, for: indexPath) as! FlagCell
            cell.sender = { isFlaged in self.isFlaged = isFlaged }
            return cell
        default:
            return UITableViewCell()
        }

    }
}
