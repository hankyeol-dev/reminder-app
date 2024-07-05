//
//  AddTaskViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit
import RealmSwift
import Toast

final class AddTaskViewController: BaseViewController {
    private var due: Date?
    private var priority: String = ""
    private var tags: String = ""
    
    private let mainView = AddTaskView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNav(
            title: "새로운 할 일",
            leftBarItem: UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissVC)),
            rightBarItem: UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(saveTask))
        )
        navigationItem.leftBarButtonItem?.tintColor = .systemGreen
        guard let text = mainView.field.titleField.text else { return }
        
        if !text.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    override func configureAction() {
        super.configureAction()
        mainView.addAction(object: mainView.goDetail.button, target: self, action: #selector(goTaskDetail), event: .touchUpInside)
    }
}

extension AddTaskViewController {
    @objc
    func dismissVC() {
        self.dismiss(animated: true)
    }
    
    @objc
    func saveTask() {
        guard let titleText = mainView.field.titleField.text,
              let memoText = mainView.field.memoField.text else {
            print("여기가 nil?")
            return
        }
        guard let due = self.due else {
            print("due가 nil?")
            return
        }
        guard self.priority != "" || self.priority != "없음" else {
            print("priority가 nil?")
            return
        }
        guard self.tags != "" else {
            print("아니면 태그가?")
            return
        }
        
        do {
            let db = try Realm()
            let task = Tasks(title: titleText, memo: memoText, dueDate: due)
            let tag = Tags(name: self.tags)
            
            try db.write {
                db.add(task)
                db.add(tag)
            }
            self.dismiss(animated: true)
        } catch {
            self.mainView.makeToast("새로운 할 일을 저장할 수 없어요 :(", duration: 5, position: .bottom)
        }
    }
    
    @objc
    func goTaskDetail() {
        goSomeVC(vc: TaskDetailViewController()) { vc in
            vc.sender = {
                self.due = vc.due
                self.priority = vc.priority
                self.tags = vc.tags
            }
        }
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    private func configureTextField() {
        mainView.field.titleField.delegate = self
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if !text.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

extension AddTaskViewController: UITextViewDelegate {
    private func configureTextView() {
        mainView.field.memoField.delegate = self
        mainView.field.configureMemoFieldInit()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if text == "메모" {
            mainView.field.configureMemoFieldBegin()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if text.isEmpty {
            mainView.field.configureMemoFieldInit()
        }
    }
}
