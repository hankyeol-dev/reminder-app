//
//  TaskDetailViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/3/24.
//

import UIKit

class TaskDetailViewController: BaseViewController {
    var sender: (() -> ())?
    var due: Date?
    var priority: String = ""
    var tags: String = ""
    
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
        
        table.register(DuedateCell.self, forCellReuseIdentifier: DuedateCell.id)
        table.register(PriorityCell.self, forCellReuseIdentifier: PriorityCell.id)
        table.register(TagCell.self, forCellReuseIdentifier: TagCell.id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DuedateCell.id, for: indexPath) as? DuedateCell else { return UITableViewCell() }
            
            cell.sender = { d in
                self.due = d
            }
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PriorityCell.id, for: indexPath) as? PriorityCell else { return UITableViewCell() }
            
            cell.sender = { v in
                self.priority = v
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.id, for: indexPath) as? TagCell else { return UITableViewCell() }
            
            cell.sender = { v in
                if !v.isEmpty {
                    self.tags = v
                }
            }
            
            return cell
        }
    }
}
