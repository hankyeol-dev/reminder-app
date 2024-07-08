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
    var sender: (() -> ())?
    
    private let taskRepository = Repository<Tasks>()
    private let tagRepository = Repository<Tags>()
    
    private var due: Date?
    private var priority: String = ""
    private var tags: String = ""
    private var isFlaged: Bool = false
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sender?()
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
        var result:Output<Tasks>
        // 1. Task는 일단 타이틀만 있으면 만들어질 수 있다.
        guard let titleT = mainView.field.titleField.text else { return }
        let singleTask = Tasks(title: titleT, isFlaged: self.isFlaged)
        
        // 2. 메모가 있고, 비워져있지 않다면 반영해준다.
        if let memoT = mainView.field.memoField.text, !memoT.isEmpty, memoT != "메모" {
            singleTask.memo = memoT
        }
        
        // 3. 완료일이 정해져 있다면 반영해준다.
        if let due = self.due {
            singleTask.dueDate = due
        }
        
        // 4. priority는 걍 담아주면 됨.
        if self.priority != "", self.priority != "없음" {
            singleTask.priority = self.priority
        }
        
        // 5. 만약에 tag가 있다면, tags list에 반영해주고, linkingObject에도 반영해줘야 함
        if self.tags != "" {
            var relatedTag:Tags
            
            let isAlreadyIn = self.tagRepository.getRecords().output?.where({ query in
                query.name == self.tags
            })
            
            if isAlreadyIn?.count != 0 {
                // 5-1. 이미 저장된 태그라면?
                guard let isIn = isAlreadyIn, let first = isIn.first else { return }
                self.tagRepository.updateSingleRecordById(id: first.id) { tag in
                    tag.tasks.append(singleTask)
                }
                relatedTag = first
            } else {
                // 5-2. 저장되지 않은 태그라면
                relatedTag = Tags(name: self.tags)
                self.tagRepository.addRecordWithHandler(relatedTag) { tag in
                    tag.tasks.append(singleTask)
                }
                
            }
            result = self.taskRepository.addRecordWithHandler(singleTask) { task in
                task.tags.append(relatedTag)
            }
            
        } else {
            result = taskRepository.addSingleRecord(singleTask)
        }
        
        
        
        if result.ok {
            self.dismissVC()
        } else {
            view.makeToast(result.error, duration: 4)
        }
        
    }
    
    @objc
    func goTaskDetail() {
        goSomeVC(vc: TaskDetailViewController()) { vc in
            vc.sender = {
                
                if let due = vc.due {
                    self.due = due
                }
                
                self.priority = vc.priority
                self.tags = vc.tags
                self.isFlaged = vc.isFlaged
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
