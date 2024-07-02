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
    private let mainView = AddTaskView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureTextView()
    }
    
    override func configureAction() {
        super.configureAction()
        mainView.addActions(
            object: [mainView.header.cancelButton, mainView.header.saveButton],
            target: [self, self],
            action: [#selector(dismissVC), #selector(saveTask)],
            event: [.touchUpInside, .touchUpInside] 
        )
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
              let memoText = mainView.field.memoField.text else { return }
        
        do {
            let db = try Realm()
            let task = Tasks(title: titleText, memo: memoText)
            
            try db.write {
                db.add(task)
            }
            self.dismiss(animated: true)
        } catch {
            self.view.makeToast("새로운 할 일을 저장할 수 없어요 :(", duration: 5)
        }
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    private func configureTextField() {
        mainView.field.titleField.delegate = self
        mainView.header.saveButtonConfiguration(false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if !text.isEmpty {
            mainView.header.saveButtonConfiguration(true)
        } else {
            mainView.header.saveButtonConfiguration(false)
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
}
