//
//  ViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit

class MainViewController: BaseViewController {
    private let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureAction() {
        mainView.addAction(object: mainView.goButton, target: self, action: #selector(goTotalTaskLists), event: .touchUpInside)
        mainView.addAction(object: mainView.addButton, target: self, action: #selector(showAddTaskVC), event: .touchUpInside)
    }
    
}

extension MainViewController {
    @objc
    func goTotalTaskLists() {
        goSomeVC(vc: TaskListViewController()) { _ in }
    }
    
    @objc 
    func showAddTaskVC() {
        let vc = UINavigationController(rootViewController: AddTaskViewController())
        presentSomeVC(vc: vc) { _ in }
    }
}
