//
//  TagListViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/8/24.
//

import UIKit
import RealmSwift

final class TagListViewController: BaseViewController {
    private let tagRepository = Repository<Tags>()
    private var tagList: Results<Tags>!
    
    private let mainView = TaskListView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagList = tagRepository.getRecords().output?.where({ query in
            query.tasks.isCompleted == false
        })
        configureTable()
        mainView.configureTitle("태그 모아보기", .systemPurple)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tags = tagRepository.getRecords()
        
        if tags.ok {
            if let count = tags.output?.count {
                configureNav(title: "태그 모아보기 - \(count)개", leftBarItem: genLeftWithGoBack(), rightBarItem: nil)
            }
        }
        
        mainView.table.reloadData()
    }
}

extension TagListViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        let table = mainView.table
        table.delegate = self
        table.dataSource = self
        table.register(TagTableCell.self, forCellReuseIdentifier: TagTableCell.id)
        table.rowHeight = 56
        table.separatorInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TagTableCell.id, for: indexPath) as? TagTableCell else { return UITableViewCell() }
        cell.configureLabel(tagList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskListViewController()
        vc.configureViewWithData(tagList[indexPath.row])
        goSomeVC(vc: vc) { _ in }
        tableView.reloadData()
    }
}
