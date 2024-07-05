//
//  TasksListModel.swift
//  ReminderApp
//
//  Created by 강한결 on 7/5/24.
//

import UIKit

let TaskListModel = [
    CollectionItemInput(name: "오늘", icon: UIImage(systemName: "calendar")!, iconColor: .white, iconBackgroundColor: .systemBlue),
    CollectionItemInput(name: "예정", icon: UIImage(systemName: "calendar.badge.checkmark")!, iconColor: .white, iconBackgroundColor: .systemRed),
    CollectionItemInput(name: "전체", icon: UIImage(systemName: "tray.fill")!, iconColor: .white),
    CollectionItemInput(name: "깃발 표시", icon: UIImage(systemName: "flag.fill")!, iconColor: .white, iconBackgroundColor: .systemOrange),
    CollectionItemInput(name: "완료됨", icon: UIImage(systemName: "checkmark")!, iconColor: .white)
]
