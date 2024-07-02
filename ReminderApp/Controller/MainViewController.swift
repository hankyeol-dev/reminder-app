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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
    
    override func configureAction() {
        mainView.addAction(object: mainView.addButton, target: self, action: #selector(showAddTaskVC), event: .touchUpInside)
    }
    
}

extension MainViewController {
    @objc func showAddTaskVC() {
        presentSomeVC(vc: AddTaskViewController()) { _ in }
    }
}
