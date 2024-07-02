//
//  BaseViewController.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//


import UIKit

protocol ReusableId {
    static var id: String { get }
}

extension UIView: ReusableId {
    static var id: String {
        String(describing: self)
    }
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureSubview()
        configureLayout()
        configureView()
        configureAction()
    }
    
    func configureSubview() {}
    func configureLayout() {}
    func configureView() {}
    func configureAction() {}
}

extension BaseViewController {
    func configureNav(title: String, leftBarItem: UIBarButtonItem?, rightBarItem: UIBarButtonItem?) {
        
        self.title = title
        
        if let left = leftBarItem {
            navigationItem.leftBarButtonItem = left
        }
        
        if let right = rightBarItem {
            navigationItem.rightBarButtonItem = right
        }
    }
    
    func genLeftWithGoBack() -> UIBarButtonItem {
        let left = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
        left.tintColor = .darkGray
        
        return left
    }
}

extension BaseViewController {
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func goSomeVC<T: UIViewController>(vc: T, vcHandler: @escaping (T) -> ()) {
        vcHandler(vc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentSomeVC<T: UIViewController>(vc: T, vcHandler: @escaping (T) -> ()) {
        vcHandler(vc)
        present(vc, animated: true)
    }
}
